//
//  ReviewWorkoutView.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

// MARK: - Review Workout
struct ReviewWorkoutView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var nav: NavCoordinator
    @Environment(\.editMode) private var editMode

    @Bindable var workout: Workout
    @State private var showDiscardAlert = false

    // Reps editing
    @AppStorage("preferredRepsCount") private var tempReps: Int = 10
    @State private var showingRepsForm = false
    @State private var editingWex: WorkoutExercise?
    @State private var editingIndex: Int?

    private var isEditing: Bool { editMode?.wrappedValue.isEditing ?? false }

    var body: some View {
        List {
            // MARK: Details
            Section("Details") {
                HStack {
                    Text("Name")
                    Group {
                        TextField("Workout name", text: $workout.title)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .onChange(of: workout.title) { _, _ in
                                workout.dateModified = Date()
                                try? context.save()
                            }
                            .multilineTextAlignment(.trailing)
                            .disabled(!isEditing)
                        if isEditing {
                            Image(systemName: "pencil")
                        }
                    }
                    .foregroundStyle(.secondary)
                }
                .accessibilityElement(children: .combine)

                if isEditing {
                    DatePicker(
                        "Date",
                        selection: $workout.dateCompleted,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .onChange(of: workout.dateCompleted) { _, _ in
                        workout.dateModified = Date()
                        try? context.save()
                    }
                } else {
                    HStack {
                        Text("Date");
                        Spacer()
                        Text(workout.dateCompleted.formatted(date: .abbreviated, time: .omitted))
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityElement(children: .combine)
                }
            }

            Section("Muscles worked out") {
                MusculoDiagramsView.AllCoronals(
                    presenting: workout.exercises.flatMap {
                        $0.targettedMuscles.compactMap {
                            try? MusculoDiagramsView.MuscleGroup(fromMuscleWith: $0.id) { }
                        }
                    }.unique()
                )
            }

            // MARK: Exercises + reps
            if workout.exercises.isEmpty {
                Section {
                    ContentUnavailableView(
                        "No exercises",
                        systemImage: "list.bullet",
                        description: Text("Add some exercises, or discard the workout.")
                    )
                }
            } else {
                ForEach(workout.exercises) { wex in
                    Section {
                        HStack {
                            Text(wex.exercise?.name ?? Exercise.EMPTY.name).font(.headline)
                            Spacer()
                            Text("\(wex.completedSets) sets").foregroundStyle(.secondary)
                        }
                        .if(isEditing) { view in
                            view.swipeActions {
                                Button(role: .destructive) { deleteExercise(wex) } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }

                        if wex.reps.isEmpty {
                            Text("No sets").font(.caption).foregroundStyle(.secondary)
                        } else {
                            ForEach(Array(wex.reps.enumerated()), id: \.offset) { idx, reps in
                                if isEditing {
                                    Button {
                                        editingWex = wex
                                        editingIndex = idx
                                        tempReps = reps
                                        showingRepsForm = true
                                    } label: {
                                        HStack {
                                            Text("Set \(idx + 1)")
                                            Spacer()
                                            Text("\(reps) reps").foregroundStyle(.secondary).monospacedDigit()
                                        }
                                    }
                                } else {
                                    HStack {
                                        Text("Set \(idx + 1)")
                                        Spacer()
                                        Text("\(reps) reps").foregroundStyle(.secondary).monospacedDigit()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Auto-activate edit mode if this is a draft
            if workout.isDraft { editMode?.wrappedValue = .active }
        }
        .navigationTitle("Review Workout")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if isEditing {
                    Button { saveWorkout() } label: {
                        Label(workout.isDraft ? "Done" : "Save", systemImage: "square.and.arrow.down")
                    }
                    .labelStyle(.titleOnly)
                    .disabled(workout.exercises.isEmpty)
                } else {
                    EditButton()
                }
            }

            ToolbarItem(placement: .secondaryAction) {
                Button(role: .destructive) { showDiscardAlert = true } label: {
                    Label("Discard", systemImage: "trash")
                }
                .foregroundStyle(.red)
            }
        }
        .alert("Discard this workout? This action is irreversible.", isPresented: $showDiscardAlert) {
            Button("Discard", role: .destructive) { discardWorkout() }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showingRepsForm) {
            RepsEntrySheet(
                exerciseName: editingWex?.exercise?.name ?? Exercise.EMPTY.name,
                value: $tempReps,
                onSave: { newReps in
                    guard let wex = editingWex, let idx = editingIndex, idx < wex.reps.count
                    else { showingRepsForm = false; return }
                    
                    wex.reps[idx] = max(0, newReps)
                    workout.dateModified = Date()
                    try? context.save()
                    showingRepsForm = false
                },
                onCancel: { showingRepsForm = false }
            )
        }
        // If something else toggles draft off, also exit edit mode automatically
        .onChange(of: workout.isDraft) { _, isDraft in
            if !isDraft { editMode?.wrappedValue = .inactive }
        }
    }

    // MARK: - Actions

    private func deleteExercise(_ wex: WorkoutExercise) {
        withAnimation {
            context.delete(wex)
            for (i, e) in workout.exercises.enumerated() { e._order = i }
            workout.dateModified = Date()
            try? context.save()
        }
    }

    private func saveWorkout() {
        let shouldNavigateAfter = workout.isDraft
        withAnimation {
            workout.isDraft = false
            workout.dateModified = Date()
            try? context.save()
            editMode?.wrappedValue = .inactive
            if shouldNavigateAfter { goHome() }
        }
    }

    private func discardWorkout() {
        withAnimation {
            for wex in workout.exercises { context.delete(wex) }
            context.delete(workout)
            try? context.save()
            editMode?.wrappedValue = .inactive
            goHome()
        }
    }
    
    private func goHome() {
        withAnimation {
            nav.path = []
        }
    }
}
