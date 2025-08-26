//
//  HomeView.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

struct ExercisesSectionView: View {
    @Query private var exercises: [Exercise]
    
    var body: some View {
        Section("Exercises") {
            ForEach(exercises.sorted { $0.id < $1.id }) { exercise in
                VStack {
                    Text(verbatim: exercise.name)
                    Text(verbatim: exercise.id)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .navigationTitle("Exercises")
        }
    }
}

struct MuscleGroupSectionView: View {
    @Query private var muscleGroups: [MuscleGroup]
    @State private var presenting: MuscleGroup? = nil
    
    var body: some View {
        Section("Muscle Groups") {
            ForEach(muscleGroups.sorted { $0.id < $1.id }) { group in
                Button {
                    presenting = group
                } label: {
                    Text(verbatim: group.id)
                }
            }
        }
        .sheet(item: $presenting) { group in
            NavigationStack {
                List {
                    Section("Muscle Groups (ordered)") {
                        ForEach(group.exercises.sorted { $0.id < $1.id }) { ex in
                            Text(verbatim: ex.id)
                        }
                    }
                }
                .navigationTitle(group.id)
            }
        }
    }
}

struct WorkoutPresetSectionView: View {
    @Query private var workoutPresets: [WorkoutPreset]
    @State private var presenting: WorkoutPreset? = nil
    
    var body: some View {
        Section("Workout Presets") {
            ForEach(workoutPresets.group(by: \.groupId).items, id: \.key) { presetGroup in
                Section {
                    ForEach(presetGroup.value.sorted { $0.id < $1.id }) { preset in
                        Button {
                            presenting = preset
                        } label: {
                            VStack {
                                Text(verbatim: preset.name)
                                Text(verbatim: preset.id)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }
        }
        .sheet(item: $presenting) { preset in
            NavigationStack {
                List {
                    Section("Targetted Muscles (ordered)") {
                        ForEach(preset.targettedMuscles.sorted { $0.id < $1.id }) { ex in
                            Text(verbatim: ex.id)
                        }
                    }
                    
                    Section("Exercises") {
                        
                    }
                }
                .navigationTitle(preset.id)
            }
        }
    }
}


struct HomeView: View {
    @Query(filter: #Predicate<Workout> { !$0.isDraft },
           sort: [SortDescriptor(\Workout.dateCompleted, order: .reverse)])
    private var workouts: [Workout]

    @Query(filter: #Predicate<Workout> { $0.isDraft })
    private var draftWorkouts: [Workout]

    @Environment(\.modelContext) private var context
    @StateObject private var nav = NavCoordinator()

    @State private var showDiscardAlert = false
    @State private var selectedDraft: Workout?

    @State private var showDebugSheet: Bool = false
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            List {
                if let draft = activeDraft, !isExpired(draft) {
                    Section {
                        VStack(alignment: .leading) {
                            Label {
                                Text("Workout in progress")
                                    .font(.headline)
                            } icon: {
                                Image(systemName: "bolt.fill")
                                    .symbolRenderingMode(.multicolor)
                            }

                            HStack {
                                Text(draft.preset?.name.capitalized ?? "Undefined")
                                    .font(.subheadline)
                                if let modified = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: draft.dateModified) {
                                    Text("· \(draft.dateModified.formatted(.relative(presentation: .named)))")
                                        .foregroundStyle(.secondary)
                                        .font(.caption)
                                        .accessibilityLabel("Last updated \(modified.formatted(date: .abbreviated, time: .omitted))")
                                }
                            }
                            .foregroundStyle(.secondary)

                            HStack {
                                Button {
                                    nav.path.append(.draft(draft.id))
                                } label: {
                                    Label("Continue", systemImage: "play.fill")
                                        .foregroundStyle(.primary)
                                }
                                .buttonStyle(.borderedProminent)

                                Button(role: .destructive) {
                                    selectedDraft = draft
                                    showDiscardAlert = true
                                } label: {
                                    Label("Discard", systemImage: "trash")
                                        .foregroundStyle(.red)
                                }
                                .buttonStyle(.bordered)
                            }
                            .padding(.top, 2)
                        }
                        .padding(.vertical, 6)
                    }
                }

                Section {
                    MonthlyStreakCalendarView()
                }
                
                Section {
                    ForEach(workouts) { workout in
                        Button {
                            nav.path.append(.workoutDetail(workout.id))
                        } label: {
                            VStack(alignment: .leading) {
                                Text(workout.preset?.name.capitalized ?? "Undefined")
                                    .font(.headline)
                                Text(workout.dateCompleted.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteSavedWorkouts)
                }
            }
            .navigationTitle(Text(monthTitle(.now)))
            .toolbar {
                #if DEBUG
                ToolbarItem(placement: .secondaryAction) {
                    Button {
                        showDebugSheet = true
                    } label: {
                        Label("Developer infos", systemImage: "ladybug.fill")
                    }
                }
                #endif
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
//                        WorkoutDetailView(workout: workout)
                        ReviewWorkoutView(workout: workout)
                    } else {
                        ContentUnavailableView(
                            "Workout not found",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("Workout \(id) couldn't be found. Please report this issue.")
                        )
                    }
                case .draft(let id):
                    if let workout = fetchWorkout(by: id) {
                        ExerciseSelectionView(workout: workout)
                            .environmentObject(nav)
                    } else {
                        ContentUnavailableView(
                            "Draft not found",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("Draft \(id) couldn't be found. Please report this issue.")
                        )
                    }
                case .review(let id):
                    if let workout = fetchWorkout(by: id) {
                        ReviewWorkoutView(workout: workout)
                            .environmentObject(nav)
                    } else {
                        ContentUnavailableView(
                            "Review not available",
                            systemImage: "questionmark.text.page",
                            description: Text("Review of workout \(id) not available. Please report this issue.")
                        )
                    }
                case .doExercise(let workoutId, let wexId):
                    if let workout = fetchWorkout(by: workoutId),
                       let wex = workout.exercises.first(where: { $0.id == wexId }) {
                        DoExerciseView(workout: workout, workoutExercise: wex) { _ in }
                            .environmentObject(nav)
                    } else {
                        ContentUnavailableView(
                            "Exercise not found",
                            systemImage: "exclamationmark.magnifyingglass",
                            description: Text("Exercise \(wexId) in workout \(workoutId) couldn't be found. Please report this issue.")
                        )
                    }
                }
            }
            .sheet(isPresented: $showDebugSheet) {
                NavigationStack {
                    List {
                        NavigationLink {
                            List {
                                MuscleGroupSectionView()
                            }
                        } label: {
                            Label("Muscle Groups", systemImage: "figure")
                        }
                        
                        NavigationLink {
                            List {
                                ExercisesSectionView()
                            }
                        } label: {
                            Label("Exercises", systemImage: "figure.run")
                        }
                        
                        NavigationLink {
                            List {
                                WorkoutPresetSectionView()
                            }
                        } label: {
                            Label("Workout Presets", systemImage: "camera.filters")
                        }
                    }
                    .navigationTitle("Developer infos")
                }
            }
        }
        .environmentObject(nav)
        .alert("Discard draft workout?", isPresented: $showDiscardAlert, presenting: selectedDraft) { draft in
            Button("Discard", role: .destructive) {
                for wex in draft.exercises {
                    context.delete(wex)
                }
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
    
    private func monthTitle(_ date: Date) -> AttributedString {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: date)
        let monthDate = calendar.date(from: comps) ?? date
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.setLocalizedDateFormatFromTemplate("yMMMM") // e.g., September 2025
        return AttributedString(formatter.string(from: monthDate))
    }
    
    private func deleteSavedWorkouts(_ offsets: IndexSet) {
        for index in offsets {
            let workout = workouts[index]
            context.delete(workout)
        }
        try? context.save()
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
                Text("Sets: \(wex.completedSets)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Workout Detail")
    }
}
