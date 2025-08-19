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

    @State private var showDraftAlert = false
    @State private var selectedPreset: PresetType?

    var body: some View {
        List {
            Section("Select a Preset") {
                ForEach(PresetType.allCases, id: \.self) { preset in
                    Button(action: { handlePresetSelection(preset) }) {
                        Text(preset.rawValue.capitalized)
                    }
                }
            }
        }
        .navigationTitle("Create Workout")
        .alert("A draft workout already exists", isPresented: $showDraftAlert) {
            Button("Continue") {
                if let draft = drafts.first { nav.path.append(.draft(draft.id)) }
            }
            Button("Discard", role: .destructive) {
                if let draft = drafts.first {
                    context.delete(draft)
                    try? context.save()
                }
                if let preset = selectedPreset { createWorkout(preset: preset) }
            }
            Button("Cancel", role: .cancel) {}
        }
        .task { autoDeleteExpiredDraftIfNeeded() }
    }

    private func handlePresetSelection(_ preset: PresetType) {
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

    private func createWorkout(preset: PresetType) {
        let workout = Workout(preset: preset, isDraft: true)
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

// MARK: - Exercise Selection (resume-friendly)
struct ExerciseSelectionView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var nav: NavCoordinator

    @State var workout: Workout
    @State private var available: [Exercise] = []
    @State private var navigateToExercise: WorkoutExercise?

    // Clock in toolbar (seconds)
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
                                Text("Sets so far: \(last.completedCount)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }

            Section("Exercises for \(workout.preset.rawValue.capitalized)") {
                if available.isEmpty {
                    Text("No exercises found for this preset.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(available, id: \.id) { exercise in
                        Button(exercise.name) { start(exercise: exercise) }
                    }
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
        let order = workout.exercises.count
        let wex = WorkoutExercise(exercise: exercise, order: order, completedCount: 0)
        workout.exercises.append(wex)
        workout.dateModified = Date()
        context.insert(wex)
        try? context.save()
        navigateToExercise = wex
    }

    private func loadExercises() async {
        do {
            let descriptor = FetchDescriptor<Exercise>(sortBy: [SortDescriptor(\.name, order: .forward)])
            let all = try context.fetch(descriptor)
            available = all.filter { $0.presets.contains(workout.preset) }
        } catch { available = [] }
    }
}

// MARK: - Do Exercise (MVP logging)
struct DoExerciseView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var nav: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    let workout: Workout
    @State var workoutExercise: WorkoutExercise
    var onUpdated: (WorkoutExercise) -> Void

    // Clock in toolbar
    @State private var now: Date = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 6) {
                Text(workoutExercise.exercise.name)
                    .font(.title2).bold()
                Text("Preset: \(workout.preset.rawValue.capitalized)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text("Sets completed: \(workoutExercise.completedCount)")
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
    }

    private func completeSet() {
        workoutExercise.completedCount += 1
        workoutExercise.exercise = workoutExercise.exercise // touch to ensure change tracking
        try? context.save()
        onUpdated(workoutExercise)
    }

    private func completeExercise() {
        workoutExercise.completedCount = max(1, workoutExercise.completedCount + 1)
        try? context.save()
        onUpdated(workoutExercise)
        dismiss()
    }
}

