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

    var body: some View {
        VStack(spacing: 0) {
            List {
                Section("Details") {
                    if workout.isDraft {
                        DatePicker(
                            "Date",
                            selection: $workout.dateCompleted,
                            in: ...Date(),
                            displayedComponents: [.date],
                        )
                        .onChange(of: workout.dateCompleted) { oldValue, newValue in
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
                
                Section("Preset") {
                    Text(verbatim: workout.preset?.name ?? "Undefined")
                }

                if workout.exercises.isEmpty {
                    Section {
                        ContentUnavailableView(
                            "No exercises",
                            systemImage: "list.bullet",
                            description: Text("Add some exercises, or discard the workout.")
                        )
                    }
                } else {
                    Section("Exercises (in order)") {
                        ForEach(workout.exercises) { wex in
                            HStack {
                                Text(wex.exercise.name)
                                Spacer()
                                Text("\(wex.completedSets)x")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        // Editable only when draft
                        .onDelete(perform: workout.isDraft ? delete : nil)
                    }
                }
            }

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
    }

    // MARK: - Actions
    private func delete(_ offsets: IndexSet) {
        for index in offsets {
            let wex = workout.exercises[index]
            context.delete(wex)
        }
        workout.exercises.remove(atOffsets: offsets)
        workout.dateModified = Date()
        try? context.save()
    }

    private func saveWorkout() {
        workout.isDraft = false
        workout.dateModified = Date()
        try? context.save()
        nav.path = [] // pop to Home
    }

    private func discardWorkout() {
        context.delete(workout)
        try? context.save()
        nav.path = [] // pop to Home
    }
}

