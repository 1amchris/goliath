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
                            Button {
                                withAnimation { handlePresetSelection(preset) }
                            } label: {
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
                withAnimation {
                    if let draft = drafts.first {
                        nav.path.append(.draft(draft.id))
                    }
                }
            }
            Button("Discard", role: .destructive) {
                withAnimation {
                    if let draft = drafts.first {
                        context.delete(draft)
                        try? context.save()
                    }
                    if let preset = selectedPreset {
                        createWorkout(preset: preset)
                    }
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
        workout.reevaluateTitleIfNeeded()
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
    @State private var allExercises: [Exercise] = []
    @State private var navigateToExercise: WorkoutExercise?

    // Base filtering + sorting (preferred first, then A→Z)
    private var filteredExercises: [Exercise] {
        let q = searchPredicate.trimmingCharacters(in: .whitespacesAndNewlines)
        let base: [Exercise]

        if q.isEmpty {
            base = allExercises
        } else {
            let needle = q.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            base = allExercises.filter { ex in
                let hay = ex.name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                let words = hay.split(separator: " ")
                return words.contains { $0.hasPrefix(needle) } || hay.contains(needle)
            }
        }

        return base.sorted {
            if $0.userPreferred != $1.userPreferred {
                return $0.userPreferred && !$1.userPreferred
            }
            return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }

    // Split into matching vs others for the current preset
    private var splitByPreset: (matching: [Exercise], others: [Exercise]) {
        let targetIds = Set(workout.preset?.targettedMuscles.map(\.id) ?? [])
        guard !targetIds.isEmpty else { return (filteredExercises, []) }

        let matching = filteredExercises.filter { ex in
            ex.targettedMuscles.contains { targetIds.contains($0.id) }
        }
        let others = filteredExercises.filter { ex in
            !ex.targettedMuscles.contains { targetIds.contains($0.id) }
        }
        return (matching, others)
    }

    var body: some View {
        List {
            if let last = workout.exercises.last {
                Section("Resume") {
                    Button(action: { open(existing: last) }) {
                        HStack {
                            Image(systemName: "arrow.uturn.right")
                            VStack(alignment: .leading) {
                                Text(last.exercise?.name ?? Exercise.EMPTY.name)
                                Text("Sets so far: \(last.completedSets)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }

            if let preset = workout.preset {
                let sections = splitByPreset

                // Section 1 — exercises that match the preset’s muscles
                Section("Exercises for \(preset.name.capitalized)") {
                    if allExercises.isEmpty {
                        ContentUnavailableView(
                            "No exercises found",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("There are no exercises available.")
                        )
                    } else if sections.matching.isEmpty {
                        ContentUnavailableView(
                            "No matching exercises",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("Try a different search or pick from Other exercises below.")
                        )
                    } else {
                        ForEach(sections.matching) { exercise in
                            exerciseRow(exercise)
                        }
                    }
                }

                // Section 2 — other exercises (not matching preset muscles)
                if !sections.others.isEmpty {
                    Section("Other exercises") {
                        ForEach(sections.others) { exercise in
                            exerciseRow(exercise)
                        }
                    }
                }
            } else {
                Section {
                    ContentUnavailableView(
                        "No preset selected",
                        systemImage: "questionmark.app.dashed",
                        description: Text("Somehow, no preset has been selected for this workout. Please report this issue.")
                    )
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

    // MARK: - Row

    @ViewBuilder
    private func exerciseRow(_ exercise: Exercise) -> some View {
        HStack {
            Text.highlightMatches(in: exercise.name, query: searchPredicate)
            Spacer()
            Button {
                withAnimation {
                    exercise.userPreferred.toggle()
                    try? context.save()
                }
            } label: {
                Image(systemName: exercise.userPreferred ? "star.fill" : "star")
            }
            .buttonStyle(.borderless)
        }
        .contentShape(Rectangle())
        .onTapGesture { start(exercise: exercise) }
    }

    // MARK: - Actions / Data

    private func open(existing: WorkoutExercise) { navigateToExercise = existing }

    private func start(exercise: Exercise) {
        if let last = workout.exercises.last, last.reps.isEmpty {
            // Replace the not-yet-started exercise in-place
            last.exercise = exercise
            workout.dateModified = Date()
            try? context.save()
            navigateToExercise = last
        } else {
            // Append a new workout exercise
            let wex = WorkoutExercise(exercise: exercise, workout: workout, order: workout.exercises.count)
            workout.dateModified = Date()
            context.insert(wex)
            try? context.save()
            navigateToExercise = wex
        }
    }

    private func loadExercises() async {
        do {
            // Fetch ALL exercises; we split into sections in-memory
            allExercises = try context.fetch(FetchDescriptor<Exercise>(
                sortBy: [SortDescriptor(\Exercise.name, order: .forward)]
            ))
        } catch {
            allExercises = []
        }
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
                        Text(workoutExercise.exercise?.name ?? Exercise.EMPTY.name)
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

        // Add/Edit reps
        .sheet(isPresented: $showingRepsForm) {
            RepsEntrySheet(
                exerciseName: workoutExercise.exercise?.name ?? Exercise.EMPTY.name,
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
        // Rest timer after logging a new set (not when editing)
        .sheet(isPresented: $showingRestTimer) {
            RestTimerSheet(
                preferredDuration: $preferredRestSeconds,
                onNextExercise: completeExercise
            )
            .interactiveDismissDisabled()
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
                        Button { value = max(0, value - 4) }    label: { Text("-4") }
                        Button { value = max(0, value - 1) }    label: { Text("-1") }
                        Spacer()
                        Button { value += 1 }                   label: { Text("+1") }
                        Button { value += 4 }                   label: { Text("+4") }
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
