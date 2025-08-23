//
//  CreateWorkoutView.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

// MARK: - Create Workout
struct CreateWorkoutView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var nav: NavCoordinator
    @Query(filter: #Predicate<Workout> { $0.isDraft }) var drafts: [Workout]

    @Query var presets: [WorkoutPreset]

    @State private var showDraftAlert = false
    @State private var selectedPreset: WorkoutPreset?

    var body: some View {
        List {
            if presets.isEmpty {
                ContentUnavailableView(
                    "No presets",
                    systemImage: "questionmark.app.dashed",
                    description: Text("We couldn't retrieve any presets.")
                )
            } else {
                ForEach(presets.group(by: \.groupId).items, id: \.key) { presetGroup in
                    Section {
                        ForEach(presetGroup.value.sorted { $0.id < $1.id }) { preset in
                            Button(action: { handlePresetSelection(preset) }) {
                                Text(preset.name.capitalized)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Create a Workout")
        .alert("A draft workout already exists", isPresented: $showDraftAlert) {
            Button("Continue") {
                if let draft = drafts.first { nav.path.append(.draft(draft.id)) }
            }
            Button("Discard", role: .destructive) {
                if let draft = drafts.first {
                    context.delete(draft)
                    try? context.save()
                }
                if let preset = selectedPreset {
                    createWorkout(preset: preset)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        .task { autoDeleteExpiredDraftIfNeeded() }
    }

    private func handlePresetSelection(_ preset: WorkoutPreset) {
        if let draft = drafts.first {
            if isExpired(draft) {
                context.delete(draft)
                try? context.save()
                createWorkout(preset: preset)
            } else {
                selectedPreset = preset
                showDraftAlert = true
            }
        } else {
            createWorkout(preset: preset)
        }
    }

    private func createWorkout(preset: WorkoutPreset) {
        let workout = Workout(isDraft: true)
        workout.preset = preset
        context.insert(workout)
        try? context.save()
        nav.path.append(.draft(workout.id))
    }

    private func isExpired(_ workout: Workout) -> Bool {
        guard let hours = Calendar.current.dateComponents([.hour], from: workout.dateModified, to: Date()).hour else {
            return false
        }
        return hours >= 24
    }

    private func autoDeleteExpiredDraftIfNeeded() {
        if let draft = drafts.first, isExpired(draft) {
            context.delete(draft)
            try? context.save()
        }
    }
}

// MARK: - Exercise Selection
struct ExerciseSelectionView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var nav: NavCoordinator

    @State var workout: Workout
    @State private var available: [Exercise] = []
    @State private var navigateToExercise: WorkoutExercise?

    @State private var now: Date = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        List {
            if let last = workout.exercises.last {
                Section("Resume") {
                    Button(action: { open(existing: last) }) {
                        HStack {
                            Image(systemName: "arrow.uturn.right")
                            VStack(alignment: .leading) {
                                Text(last.exercise.name)
                                Text("Sets so far: \(last.completedSets)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }

            if let preset = workout.preset {
                Section("Exercises for \(preset.name.capitalized)") {
                    if available.isEmpty {
                        Text("No exercises found for this preset.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(available) { exercise in
                            Button(exercise.name) { start(exercise: exercise) }
                        }
                    }
                }
            } else {
                Section {
                    ContentUnavailableView(
                        "No preset selected",
                        systemImage: "questionmark.app.dashed",
                        description: Text("Somehow, no preset has been selected for this workout. Please report this issue."))
                }
            }
        }
        .navigationTitle("Select Exercise")
        .navigationDestination(item: $navigateToExercise) { wex in
            DoExerciseView(workout: workout, workoutExercise: wex) { updated in
                if let idx = workout.exercises.firstIndex(where: { $0.id == updated.id }) {
                    workout.exercises[idx] = updated
                }
                workout.dateModified = Date()
                try? context.save()
            }
            .environmentObject(nav)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(now.formatted(.dateTime.hour().minute().second()))
                    .monospacedDigit()
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("End Workout") { nav.path.append(.review(workout.id)) }
            }
        }
        .onReceive(timer) { now = $0 }
        .task { await loadExercises() }
    }

    private func open(existing: WorkoutExercise) { navigateToExercise = existing }

    private func start(exercise: Exercise) {
        let wex = WorkoutExercise(exercise: exercise, workout: workout, order: workout.exercises.count)
        workout.dateModified = Date()
        context.insert(wex)
        try? context.save()
        navigateToExercise = wex
    }

    private func loadExercises() async {
        guard let preset = workout.preset else {
            available = []
            return
        }
        
        do {
            let targettedMuscleIds = Set(preset.targettedMuscles.map(\.id))
            available = try context.fetch(FetchDescriptor<Exercise>(
                predicate: #Predicate { ex in
                    ex.targettedMuscles.contains { mg in targettedMuscleIds.contains(mg.id) } },
                sortBy: [SortDescriptor(\.name, order: .forward)]
            ))
        } catch { available = [] }
    }
}

// MARK: - Do Exercise (MVP logging)
struct DoExerciseView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var nav: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("preferredRestSeconds") private var preferredRestSeconds: Double = 90
    @State private var showingRestTimer: Bool = false
    
    let workout: Workout
    @State var workoutExercise: WorkoutExercise
    var onUpdated: (WorkoutExercise) -> Void

    // Clock in toolbar
    @State private var now: Date = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 24) {
            if let preset = workout.preset {
                VStack(spacing: 6) {
                    Text(workoutExercise.exercise.name)
                        .font(.title2).bold()
                    Text("Preset: \(preset.name.capitalized)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text(verbatim: "No preset selected for workout.")
            }

            Text("Sets completed: \(workoutExercise.completedSets)")
                .font(.headline)

            VStack(spacing: 12) {
                Button(action: completeSet) {
                    Label("Complete Set", systemImage: "checkmark.circle.fill")
                }
                .buttonStyle(.borderedProminent)

                Button(action: completeExercise) {
                    Label("Complete Exercise", systemImage: "flag.checkered")
                }
                .buttonStyle(.bordered)
                .disabled(workoutExercise.completedSets < 1)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Do Exercise")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(now.formatted(.dateTime.hour().minute().second()))
                    .monospacedDigit()
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .onReceive(timer) { now = $0 }
        .sheet(isPresented: $showingRestTimer) {
            RestTimerSheet(
                preferredDuration: $preferredRestSeconds,
                onFinish: {
                    // continue same exercise after rest
                },
                onSkip: {
                    // user skipped rest
                },
                onNextExercise: completeExercise
            )
        }
    }

    private func completeSet() {
        showingRestTimer = true
        workoutExercise.completedSets += 1
        workoutExercise.exercise = workoutExercise.exercise // touch to ensure change tracking
        try? context.save()
        onUpdated(workoutExercise)
    }

    private func completeExercise() {
        showingRestTimer = false
        workoutExercise.completedSets = max(1, workoutExercise.completedSets)
        try? context.save()
        onUpdated(workoutExercise)
        dismiss()
    }
}

