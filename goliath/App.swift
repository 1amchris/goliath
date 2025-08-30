//
//  goliathApp.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

@main
struct GoliathApp: App {
    let container: ModelContainer?

    init() {
        let schema = Schema([Workout.self, WorkoutExercise.self,
            Exercise.self, WorkoutPreset.self, MuscleGroup.self])
        let config = ModelConfiguration()

        if let modelContainer = try? ModelContainer(for: schema, configurations: config) {
            //                DataLoader.deleteAll(in: container.mainContext)
            DataLoader.seedMusclesIfNeeded(context: modelContainer.mainContext)
            DataLoader.seedExercisesIfNeeded(context: modelContainer.mainContext)
            DataLoader.seedWorkoutPresetsIfNeeded(context: modelContainer.mainContext)
            container = modelContainer
        } else {
            print("Failed to set up SwiftData.")
            container = nil
        }
    }

    var body: some Scene {
        WindowGroup {
            if let modelContainer = container {
                HomeView().modelContainer(modelContainer)
            } else {
                ContentUnavailableView(
                    "Failed to launch.",
                    systemImage: "exclamationmark.triangle.fill",
                    description: Text("Couldn't initialize the SwiftData model container. If you see this, please report this issue.")
                )
            }
        }
    }
}
