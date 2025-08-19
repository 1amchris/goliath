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
            // Define the schema & container
            let schema = Schema([Workout.self, WorkoutExercise.self, Exercise.self])
            let config = ModelConfiguration() // persistent on-disk store
            container = try ModelContainer(for: schema, configurations: config)

            // Seed only if empty
            let context = container.mainContext
            let existing = try context.fetch(FetchDescriptor<Workout>())
            if existing.isEmpty {
                #if DEBUG
                SampleDataLoader.loadSampleData(context: context)
                #endif
            }
        } catch {
            fatalError("Failed to set up SwiftData container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(container)
    }
}
