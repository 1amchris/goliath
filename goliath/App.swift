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
        do {
            let schema = Schema([Workout.self, WorkoutExercise.self, Exercise.self])
            let config = ModelConfiguration()
            container = try ModelContainer(for: schema, configurations: config)
            ExerciseJSONLoader.deleteAllExercises(context: container.mainContext)
            ExerciseJSONLoader.seedIfNeeded(context: container.mainContext)
        } catch {
            fatalError("Failed to set up SwiftData: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(container)
    }
}
