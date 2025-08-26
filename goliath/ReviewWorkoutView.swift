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
    
    @Bindable var workout: Workout
    @State private var showDiscardAlert = false
    
    // Reps editing
    @AppStorage("preferredRepsCount") private var tempReps: Int = 10
    @State private var showingRepsForm = false
    @State private var editingWex: WorkoutExercise?
    @State private var editingIndex: Int?
    
    var body: some View {
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
                ForEach(workout.exercises) { wex in
                    Section {
                        HStack {
                            Text(wex.exercise.name).font(.headline)
                            Spacer()
                            Text("\(wex.completedSets) sets")
                                .foregroundStyle(.secondary)
                        }
                        .if(workout.isDraft) { view in
                            view.swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deleteExercise(wex)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }

                        if wex.reps.isEmpty {
                            Text("No sets")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else {
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
                }
            }
        }
        .navigationTitle("Review Workout")
        .toolbar {
            if workout.isDraft {
                ToolbarItem(placement: .primaryAction) {
                    Button { saveWorkout() } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .labelStyle(.titleOnly)
                    .disabled(workout.exercises.isEmpty)
                }
            }
            ToolbarItem(placement: .secondaryAction) {
                Button(role: .destructive) {
                    showDiscardAlert = true
                } label: {
                    Label("Discard", systemImage: "trash")
                }
                .foregroundStyle(.red)
            }
        }
        
        .alert("Discard this workout? This action is irreversible.", isPresented: $showDiscardAlert) {
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
    
    private func deleteExercise(_ wex: WorkoutExercise) {
        withAnimation {
            context.delete(wex)
            renumberExerciseOrders()
            workout.dateModified = Date()
            try? context.save()
        }
    }

    private func renumberExerciseOrders() {
        for (i, wex) in workout.exercises.enumerated() { wex._order = i }
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
