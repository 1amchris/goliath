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
    let container: ModelContainer

    init() {
        let schema = Schema([Workout.self, WorkoutExercise.self, Exercise.self])
        let config = ModelConfiguration()

        var hasFailedBefore = false
        while true {
            do {
                container = try ModelContainer(for: schema, configurations: config)
                if hasFailedBefore { DataLoader.deleteAll(in: container.mainContext) }
                DataLoader.seedMusclesIfNeeded(context: container.mainContext)
                DataLoader.seedExercisesIfNeeded(context: container.mainContext)
                DataLoader.seedWorkoutPresetsIfNeeded(context: container.mainContext)
                break
            } catch {
                guard !hasFailedBefore
                else { fatalError("Failed to set up SwiftData: \(error)") }

                hasFailedBefore = true
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(container)
    }
}
