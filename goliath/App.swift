//
//  goliathApp.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData
import CloudKit
import UserNotifications

// MARK: - AppController (owns container + restart token)

@MainActor
final class AppController: ObservableObject {
 
    enum StoreMode {
        case auto
        case localOnly
    }

    @Published var container: ModelContainer?
    @Published var restartToken = UUID()

    init() {
        Task {
            #if DEBUG
            self.container = await Self.makeContainerAndSeed(mode: .localOnly)
            #else
            self.container = await Self.makeContainerAndSeed(mode: .auto)
            #endif
            self.restartToken = UUID()
        }
    }

    /// Rebuilds the model container and refreshes the SwiftUI tree.
    /// If `wipe` is true, it deletes all data first (best-effort).
    func rebuildContainer(wipe: Bool = false) async {
        if wipe, let ctx = container?.mainContext {
            DataLoader.deleteAll(in: ctx)
        }

        #if DEBUG
        self.container = await Self.makeContainerAndSeed(mode: .localOnly)
        #else
        self.container = await Self.makeContainerAndSeed(mode: .auto)
        #endif

        self.restartToken = UUID()
    }

    // MARK: factory
    static func makeContainerAndSeed(mode: StoreMode = .auto) async -> ModelContainer? {
        let schema = Schema([Workout.self, WorkoutExercise.self, Exercise.self, WorkoutPreset.self, MuscleGroup.self])
        let containerID = "iCloud.com.1amchris.goliath"

        let config: ModelConfiguration
        switch mode {
        case .localOnly:
            config = ModelConfiguration()
        case .auto:
            let status = try? await CKContainer(identifier: containerID).accountStatus()
            config = (status == .available)
                ? ModelConfiguration(containerID)
                : ModelConfiguration()
        }
        
        print("ModelConfig couldKitContainerIdentifier: \(config.cloudKitContainerIdentifier ?? "undefined")")

        do {
            let mc = try ModelContainer(for: schema, configurations: config)
            DataLoader.consolidateAndSeedModels(in: mc.mainContext)
            return mc
        } catch {
            // Fallback to local if CloudKit config failed
            do {
                let local = try ModelContainer(for: schema, configurations: ModelConfiguration())
                DataLoader.consolidateAndSeedModels(in: local.mainContext)
                return local
            } catch {
                print("Caught an error while initializing SwiftData: \(error)")
                return nil
            }
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
                        .onAppear {
                            UNUserNotificationCenter.current().getNotificationSettings { settings in
                                guard settings.authorizationStatus == .notDetermined else { return }
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
                            }
                        }
                } else {
                    VStack {
                        ContentUnavailableView(
                            "Failed to launch.",
                            systemImage: "exclamationmark.triangle.fill",
                            description: Text("Couldn't initialize the SwiftData model container.")
                        )
                        Button("Reload the app") { showWarning = true }
                    }
                    .padding()
                }
            }
            .confirmationDialog("Please confirm", isPresented: $showWarning) {
                Button("Wipe everything, then reload", role: .destructive) { showDeleteConfirmation = true }
                Button("Only reload") {
                    Task { await app.rebuildContainer(wipe: false) }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Would you like to reload the app, or delete everything and start fresh?")
            }
            .confirmationDialog("Please confirm", isPresented: $showDeleteConfirmation) {
                Button("Delete everything", role: .destructive) {
                    Task { await app.rebuildContainer(wipe: true) }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Deleting everything is irreversible and will affect iCloud if enabled.")
            }
            .symbolRenderingMode(.hierarchical)
        }
    }
}
