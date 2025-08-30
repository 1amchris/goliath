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
    @State private var searchPredicate: String = ""
    @State private var available: [Exercise] = []
    @State private var navigateToExercise: WorkoutExercise?

    private var filteredAvailable: [Exercise] {
        let q = searchPredicate.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return available }

        let needle = q.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        return available.filter { ex in
            let hay = ex.name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            let words = hay.split(separator: " ")
            return words.contains(where: { $0.hasPrefix(needle) }) || hay.contains(needle)
        }
    }

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
                        ContentUnavailableView(
                            "No exercises found",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("There are no exercises available for this preset.")
                        )
                    } else if filteredAvailable.isEmpty {
                        ContentUnavailableView(
                            "No exercises found",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("Widen your search, look for something else, or report a missing exercise.")
                        )
                    } else {
                        ForEach(filteredAvailable) { exercise in
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
            ToolbarItem(placement: .primaryAction) {
                Button("End Workout") { nav.path.append(.review(workout.id)) }
            }
        }
        .task { await loadExercises() }
        .searchable(text: $searchPredicate)
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

    @AppStorage("preferredRepsCount") private var tempReps: Int = 10
    @State private var showingRepsForm: Bool = false
    @AppStorage("preferredRestSeconds") private var preferredRestSeconds: Double = 90
    @State private var showingRestTimer: Bool = false

    let workout: Workout
    @State var workoutExercise: WorkoutExercise
    var onUpdated: (WorkoutExercise) -> Void

    // Track which set is being edited (nil = adding a new set)
    @State private var editingIndex: Int? = nil

    var body: some View {
        List {
            Section {
                if let preset = workout.preset {
                    HStack {
                        Text("Exercise"); Spacer()
                        Text(workoutExercise.exercise.name)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Preset"); Spacer()
                        Text(preset.name.capitalized)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    ContentUnavailableView(
                        "No preset found.",
                        systemImage: "exclamationmark.magnifyingglass",
                        description: Text("The selected workout is not assigned to a preset. Please report this issue.")
                    )
                }
            }

            Section("Sets completed: \(workoutExercise.completedSets)") {
                if workoutExercise.reps.isEmpty {
                    ContentUnavailableView(
                        "Get started!",
                        systemImage: "figure.run",
                        description: Text("Get started by completing one set. Then press the 'Complete Set' button below!")
                    )
                } else {
                    ForEach(Array(workoutExercise.reps.enumerated()), id: \.offset) { index, repCount in
                        Button {
                            editingIndex = index
                            tempReps = repCount
                            showingRepsForm = true
                        } label: {
                            HStack {
                                Text("Set \(index + 1)")
                                Spacer()
                                Text("\(repCount) reps")
                                    .foregroundStyle(.secondary)
                                    .monospacedDigit()
                            }
                        }
                    }
                }
            }

            Button(action: completeSet) {
                Label("Complete Set", systemImage: "checkmark.circle.fill")
            }
        }
        .navigationTitle("Do Exercise")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: completeExercise) {
                    Label("Next exercise", systemImage: "forward.end.alt.fill")
                }
                .disabled(workoutExercise.reps.isEmpty)
                .labelStyle(.titleOnly)
            }
        }

        // Rest timer after logging a new set (not when editing)
        .sheet(isPresented: $showingRestTimer) {
            RestTimerSheet(
                preferredDuration: $preferredRestSeconds,
                onNextExercise: completeExercise
            )
        }

        // Add/Edit reps
        .sheet(isPresented: $showingRepsForm) {
            RepsEntrySheet(
                exerciseName: workoutExercise.exercise.name,
                value: $tempReps,
                onSave: { reps in
                    withAnimation {
                        if let idx = editingIndex {
                            workoutExercise.reps[idx] = reps
                        } else {
                            workoutExercise.reps.append(reps)
                            showingRestTimer = true
                        }
                        workout.dateModified = Date()
                        try? context.save()

                        showingRepsForm = false
                        editingIndex = nil
                    }
                },
                onCancel: {
                    showingRepsForm = false
                    editingIndex = nil
                }
            )
        }
    }

    private func completeSet() {
        editingIndex = nil
        if tempReps <= 0 { tempReps = 10 }
        showingRepsForm = true
    }

    private func completeExercise() {
        showingRepsForm = false
        showingRestTimer = false
        dismiss()
    }
}

struct RepsEntrySheet: View {
    let exerciseName: String
    @Binding var value: Int
    let onSave: (Int) -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Completed reps") {
                    HStack {
                        Text(exerciseName)
                        Spacer()
                        Text("\(value)")
                            .font(.title2)
                            .monospacedDigit()
                    }

                    HStack {
                        Button { value = max(0, value - 5) }    label: { Text("-5") }
                        Button { value = max(0, value - 1) }    label: { Text("-1") }
                        Spacer()
                        Button { value += 1 }                   label: { Text("+1") }
                        Button { value += 5 }                   label: { Text("+5") }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Log Set")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(max(0, value))
                    }
                    .disabled(value <= 0)
                }
            }
        }
        .presentationDetents([.fraction(0.5), .medium])
        .presentationDragIndicator(.visible)
    }
}
