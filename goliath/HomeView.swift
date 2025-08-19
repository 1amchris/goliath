//
//  HomeView.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(filter: #Predicate<Workout> { !$0.isDraft }, sort: [SortDescriptor(\Workout.dateCreated, order: .reverse)])
    private var workouts: [Workout]

    @Query(filter: #Predicate<Workout> { $0.isDraft })
    private var draftWorkouts: [Workout]

    @Environment(\.modelContext) private var context
    @StateObject private var nav = NavCoordinator()

    @State private var showDiscardAlert = false
    @State private var selectedDraft: Workout?

    var body: some View {
        NavigationStack(path: $nav.path) {
            VStack(spacing: 12) {
                if let draft = activeDraft, !isExpired(draft) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("You have a workout in progress")
                            .font(.headline)
                        Text("Preset: \(draft.preset.rawValue.capitalized)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        HStack {
                            Button("Continue") { nav.path.append(.draft(draft.id)) }
                                .buttonStyle(.borderedProminent)
                            Button("Discard") {
                                selectedDraft = draft
                                showDiscardAlert = true
                            }
                            .buttonStyle(.bordered)
                            .tint(.red)
                        }
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                List(workouts) { workout in
                    Button {
                        nav.path.append(.workoutDetail(workout.id))
                    } label: {
                        VStack(alignment: .leading) {
                            Text(workout.preset.rawValue.capitalized)
                                .font(.headline)
                            Text(workout.dateCreated.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .navigationTitle("Workouts")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink(destination: CreateWorkoutView().environmentObject(nav)) {
                            Label("New Workout", systemImage: "plus")
                        }
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .workoutDetail(let id):
                        if let workout = fetchWorkout(by: id) {
                            WorkoutDetailView(workout: workout)
                        } else { Text("Workout not found") }
                    case .draft(let id):
                        if let workout = fetchWorkout(by: id) {
                            ExerciseSelectionView(workout: workout)
                                .environmentObject(nav)
                        } else { Text("Draft not found") }
                    case .review(let id):
                        if let workout = fetchWorkout(by: id) {
                            ReviewWorkoutView(workout: workout)
                                .environmentObject(nav)
                        } else { Text("Review not available") }
                    case .doExercise(let workoutId, let wexId):
                        if let workout = fetchWorkout(by: workoutId),
                           let wex = workout.exercises.first(where: { $0.id == wexId }) {
                            DoExerciseView(workout: workout, workoutExercise: wex) { _ in }
                                .environmentObject(nav)
                        } else { Text("Exercise not found") }
                    }
                }
            }
        }
        .environmentObject(nav)
        .alert("Discard draft workout?", isPresented: $showDiscardAlert, presenting: selectedDraft) { draft in
            Button("Discard", role: .destructive) {
                context.delete(draft)
                try? context.save()
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    private var activeDraft: Workout? { draftWorkouts.first }

    private func isExpired(_ workout: Workout) -> Bool {
        guard let hours = Calendar.current.dateComponents([.hour], from: workout.dateModified, to: Date()).hour else {
            return false
        }
        return hours >= 24
    }
}

extension HomeView {
    func fetchWorkout(by id: UUID) -> Workout? {
        (try? context.fetch(FetchDescriptor<Workout>(predicate: #Predicate { $0.id == id })))?.first
    }
}

struct WorkoutDetailView: View {
    let workout: Workout

    var body: some View {
        List(workout.exercises) { wex in
            VStack(alignment: .leading) {
                Text(wex.exercise.name)
                Text("Sets: \(wex.completedCount)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Workout Detail")
    }
}
