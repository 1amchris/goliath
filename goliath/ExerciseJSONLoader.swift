//
//  ExerciseLoader.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import Foundation
import SwiftData

struct ExerciseDTO: Codable, Hashable {
    let name: String
    let presets: [PresetType]
}

enum ExerciseJSONLoader {
    /// Tries to load `exercises.json` from the app bundle; if missing, falls back to the built-in default JSON below.
    static func loadCatalog() -> [ExerciseDTO] {
        if let url = Bundle.main.url(forResource: "exercises", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let items = try? JSONDecoder().decode([ExerciseDTO].self, from: data) {
            return items
        }
        // Fallback to built-in JSON so the app runs even without a bundled file.
        let data = Data(defaultExercisesJSON.utf8)
        return (try? JSONDecoder().decode([ExerciseDTO].self, from: data)) ?? []
    }

    /// Seeds SwiftData with exercises if none exist yet.
    static func seedIfNeeded(context: ModelContext) {
        do {
            let count = try context.fetchCount(FetchDescriptor<Exercise>())
            guard count == 0 else { return }
            let catalog = loadCatalog()
            for dto in catalog {
                var epresets: Set<PresetType> = Set(dto.presets)
                epresets.insert(.fullBody)
                for preset in dto.presets {
                    switch preset {
                    case .legs:
                        epresets.insert(.lowerBody)
                        break
                    case .chest, .back, .arms, .core:
                        epresets.insert(.upperBody)
                        break
                    default:
                        break
                    }
                }
                let exercise = Exercise(name: dto.name, presets: Array(epresets))
                context.insert(exercise)
            }
            try context.save()
        } catch {
            print("Failed to save context")
            // Best-effort: ignore seeding errors in MVP
        }
    }

    static func deleteAllExercises(context: ModelContext) {
        try? context.delete(model: Exercise.self)
    }

    /// Default JSON used if exercises.json isn't bundled in the app.
    static let defaultExercisesJSON: String = "[]"
}
