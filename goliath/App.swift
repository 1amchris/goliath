//
//  goliathApp.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

// MARK: - AppController (owns container + restart token)
@MainActor
final class AppController: ObservableObject {
    @Published var container: ModelContainer?
    @Published var restartToken = UUID()

    init() {
        container = Self.makeContainerAndSeed()
    }

    /// Rebuilds the model container and refreshes the SwiftUI tree.
    /// If `wipe` is true, it deletes all data first (best-effort).
    func rebuildContainer(wipe: Bool = false) {
        if wipe, let ctx = container?.mainContext {
            DataLoader.deleteAll(in: ctx)
        }
        container = Self.makeContainerAndSeed()
        restartToken = UUID()
    }

    // MARK: factory
    private static func makeContainerAndSeed() -> ModelContainer? {
        let schema = Schema([ Workout.self, WorkoutExercise.self,
            Exercise.self, WorkoutPreset.self, MuscleGroup.self ])
        let config = ModelConfiguration()

        do {
            let mc = try ModelContainer(for: schema, configurations: config)
            DataLoader.seedMusclesIfNeeded(context: mc.mainContext)
            DataLoader.seedExercisesIfNeeded(context: mc.mainContext)
            DataLoader.seedWorkoutPresetsIfNeeded(context: mc.mainContext)
            return mc
        } catch {
            print("Caught an error while initializing SwiftData: \(error)")
            return nil
        }
    }
}

@main
struct GoliathApp: App {
    @StateObject private var app = AppController()

    @State private var showWarning = false
    @State private var showDeleteConfirmation = false

    var body: some Scene {
        WindowGroup {
            Group {
                if let modelContainer = app.container {
                    HomeView()
                        .id(app.restartToken)
                        .modelContainer(modelContainer)
                } else {
                    VStack {
                        ContentUnavailableView(
                            "Failed to launch.",
                            systemImage: "exclamationmark.triangle.fill",
                            description: Text("Couldn't initialize the SwiftData model container.")
                        )
                        Button("Reload the app") {
                            showWarning = true
                        }
                    }
                    .padding()
                }
            }
            .confirmationDialog("Please confirm", isPresented: $showWarning) {
                Button("Wipe everything, then reload", role: .destructive) {
                    showDeleteConfirmation = true
                }

                Button("Only reload") {
                    app.rebuildContainer(wipe: false)
                }

                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Would you like to reload the app, or delete everything, and start fresh (Factory reset-style).")
            }
            
            .confirmationDialog("Please confirm", isPresented: $showDeleteConfirmation) {
                Button("Delete everything", role: .destructive) {
                    // Soft reset: wipe + rebuild container + rebuild UI
                    app.rebuildContainer(wipe: true)
                }

                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Deleting everything is irreversible. This will delete this app's data across all iCloud devices. Please use this action as a last resort only.")
            }
        }
    }
}
