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

    @State var workout: Workout
    @State private var showDiscardAlert = false

    // Reps editing
    @AppStorage("preferredRepsCount") private var tempReps: Int = 10
    @State private var showingRepsForm = false
    @State private var editingWex: WorkoutExercise?
    @State private var editingIndex: Int?

    var body: some View {
        VStack(spacing: 0) {
            List {
                // MARK: Details
                Section("Details") {
                    HStack {
                        Text("Preset")
                        Spacer()
                        Text(workout.preset?.name ?? "Undefined")
                            .foregroundStyle(.secondary)
                    }

                    if workout.isDraft {
                        DatePicker(
                            "Date",
                            selection: $workout.dateCompleted,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                        .onChange(of: workout.dateCompleted) {
                            workout.dateModified = Date()
                            try? context.save()
                        }
                    } else {
                        HStack {
                            Text("Date")
                            Spacer()
                            Text(workout.dateCompleted.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityElement(children: .combine)
                    }
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
                    Section(
                        content: {
                            ForEach(workout.exercises) { wex in
                                // Each exercise row with its sets (reps)
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(wex.exercise.name)
                                            .font(.headline)
                                        Spacer()
                                        Text("\(wex.completedSets) sets")
                                            .foregroundStyle(.secondary)
                                    }

                                    if wex.reps.isEmpty {
                                        Text("No sets")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    } else {
                                        // List sets; tap to edit reps
                                        ForEach(Array(wex.reps.enumerated()), id: \.offset) { idx, reps in
                                            Button {
                                                editingWex = wex
                                                editingIndex = idx
                                                tempReps = reps
                                                showingRepsForm = true
                                            } label: {
                                                HStack {
                                                    Text("Set \(idx + 1)")
                                                    Spacer()
                                                    Text("\(reps) reps")
                                                        .foregroundStyle(.secondary)
                                                        .monospacedDigit()
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            // delete only in draft
                            .onDelete(perform: workout.isDraft ? delete : nil)
                            // reorder only in draft
                            .onMove(perform: workout.isDraft ? move : nil)
                        },
                        header: {
                            Text("Exercises (in order)")
                        },
                        footer: {
                            if workout.isDraft {
                                Text("Tap a set to edit its reps. Drag handles to reorder exercises.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    )
                }
            }

            // MARK: Actions (only when draft)
            if workout.isDraft {
                HStack {
                    Button(role: .destructive) { showDiscardAlert = true } label: {
                        Label("Discard", systemImage: "trash")
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button { saveWorkout() } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(workout.exercises.isEmpty)
                }
                .padding()
                .background(.bar)
            }
        }
        .navigationTitle("Review Workout")
        .alert("Discard this workout?", isPresented: $showDiscardAlert) {
            Button("Discard", role: .destructive) { discardWorkout() }
            Button("Cancel", role: .cancel) {}
        }

        // Reps editing sheet (reuse your existing sheet)
        .sheet(isPresented: $showingRepsForm) {
            RepsEntrySheet(
                exerciseName: editingWex?.exercise.name ?? "Exercise",
                value: $tempReps,
                onSave: { newReps in
                    guard let wex = editingWex, let idx = editingIndex, idx < wex.reps.count else {
                        showingRepsForm = false
                        return
                    }
                    wex.reps[idx] = max(0, newReps)
                    workout.dateModified = Date()
                    try? context.save()
                    showingRepsForm = false
                },
                onCancel: {
                    showingRepsForm = false
                }
            )
        }
    }

    // MARK: - Actions

    private func delete(_ offsets: IndexSet) {
        for index in offsets {
            let wex = workout.exercises[index]
            context.delete(wex)
        }
        workout.exercises.remove(atOffsets: offsets)
        renumberExerciseOrders()
        workout.dateModified = Date()
        try? context.save()
    }

    private func move(from source: IndexSet, to destination: Int) {
        workout.exercises.move(fromOffsets: source, toOffset: destination)
        renumberExerciseOrders()
        workout.dateModified = Date()
        try? context.save()
    }

    private func renumberExerciseOrders() {
        // Ensure each WorkoutExercise.order matches its position
        for (i, wex) in workout.exercises.enumerated() {
            if wex.order != i { wex.order = i }
        }
    }

    private func saveWorkout() {
        workout.isDraft = false
        workout.dateModified = Date()
        try? context.save()
        nav.path = [] // pop to Home
    }

    private func discardWorkout() {
        for wex in workout.exercises {
            context.delete(wex)
        }
        context.delete(workout)
        try? context.save()
        nav.path = [] // pop to Home
    }
}
