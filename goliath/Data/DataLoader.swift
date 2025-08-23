//
//  ExerciseLoader.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import Foundation
import SwiftData

fileprivate struct ExerciseDTO: Codable, Hashable {
    let datasetId: String
    let name: String
    let muscles: [String]
}

fileprivate struct MuscleGroupDTO: Codable, Hashable {
    let id: String
}


fileprivate struct WorkoutPresetDTO: Codable, Hashable {
    let datasetId: String
    let name: String
    let muscles: [String]
}

enum DataLoader {
    private static let emptyJsonArrAsString = "[]"

    static func seedMusclesIfNeeded(context: ModelContext) {
        do {
            for group in MuscleGroup.Supported.allCases {
                let groupId = group.rawValue
                let existing = try context
                    .fetch(FetchDescriptor<MuscleGroup>(predicate: #Predicate { $0.id == groupId }))
                    .first

                if existing == nil {
                    let muscleGroup = MuscleGroup(group)
                    context.insert(muscleGroup)
                }
            }

            try context.save()
        } catch {
            print("Failed to seed muscle groups: \(error)")
            // Best-effort: ignore seeding errors in MVP
        }
    }

    static func seedExercisesIfNeeded(context: ModelContext) {
        do {
            let catalog: [ExerciseDTO] = loadDTOCatalog(forResource: "exercises")

            for dto in catalog {
                let existing = try context
                    .fetch(FetchDescriptor<Exercise>(predicate: #Predicate { $0.id == dto.datasetId }))
                    .first

                let muscles = try context
                    .fetch(FetchDescriptor<MuscleGroup>(predicate: #Predicate { dto.muscles.contains($0.id) }))

                if let ex = existing {
                    ex.name = dto.name
                    ex.targettedMuscles = muscles
                } else {
                    let ex = Exercise(id: dto.datasetId, name: dto.name, targettedMuscles: muscles)
                    context.insert(ex)
                }
            }

            try context.save()
        } catch {
            print("Failed to seed exercises: \(error)")
            // Best-effort: ignore seeding errors in MVP
        }
    }

    static func seedWorkoutPresetsIfNeeded(context: ModelContext) {
        do {
            let catalog: [[WorkoutPresetDTO]] = loadDTOCatalog(forResource: "workout-presets")

            for grouping in catalog {
                let groupId = UUID()
                for dto in grouping {
                    let existingPreset = try context
                        .fetch(FetchDescriptor<WorkoutPreset>(predicate: #Predicate { $0.id == dto.datasetId }))
                        .first
                    
                    let muscles = try context
                        .fetch(FetchDescriptor<MuscleGroup>(predicate: #Predicate { dto.muscles.contains($0.id) }))
                    
                    if let preset = existingPreset {
                        preset.name = dto.name
                        preset.targettedMuscles = muscles
                        preset.groupId = groupId
                    } else {
                        let preset = WorkoutPreset(id: dto.datasetId, groupId: groupId, name: dto.name, targeting: muscles)
                        context.insert(preset)
                    }
                }
            }

            try context.save()
        } catch {
            print("Failed to seed workout presets: \(error)")
            // Best-effort: ignore seeding errors in MVP
        }
    }
    
    static func deleteAll(in context: ModelContext) {
        try? context.delete(model: Workout.self)
        try? context.delete(model: WorkoutPreset.self)
        try? context.delete(model: WorkoutExercise.self)
        try? context.delete(model: Exercise.self)
        try? context.delete(model: MuscleGroup.self)
    }
    
    fileprivate static func loadDTOCatalog<DTO>(forResource resource: String) -> [DTO] where DTO: Decodable {
        if let url = Bundle.main.url(forResource: resource, withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let items = try? JSONDecoder().decode([DTO].self, from: data) {
            return items
        }
        // Fallback to built-in JSON so the app runs even without a bundled file.
        let data = Data(emptyJsonArrAsString.utf8)
        return (try? JSONDecoder().decode([DTO].self, from: data)) ?? []
    }

}
