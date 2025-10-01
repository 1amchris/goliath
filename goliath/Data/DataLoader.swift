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

    static func seedMusclesIfNeeded(in context: ModelContext) {
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
    
    static func consolidateDuplicateMuscleGroups(in context: ModelContext) throws {
        let all = try context.fetch(FetchDescriptor<MuscleGroup>())
        let groups = Dictionary(grouping: all, by: { $0.id })

        for (_, cluster) in groups where cluster.count > 1 {
            guard let primary = cluster.max(by: { $0.exercises.count + $0.presets.count < $1.exercises.count + $1.presets.count }) else { continue }

            for dup in cluster where dup !== primary {
                // Re-point Exercises: remove dup, add primary (preserve uniqueness)
                for ex in dup.exercises {
                    if let i = ex.targettedMuscles.firstIndex(where: { $0 === dup }) {
                        ex.targettedMuscles.remove(at: i)
                    }
                    if !ex.targettedMuscles.contains(where: { $0 === primary }) {
                        ex.targettedMuscles.append(primary)
                    }
                }

                // Re-point Presets similarly
                for pr in dup.presets {
                    if let i = pr.targettedMuscles.firstIndex(where: { $0 === dup }) {
                        pr.targettedMuscles.remove(at: i)
                    }
                    if !pr.targettedMuscles.contains(where: { $0 === primary }) {
                        pr.targettedMuscles.append(primary)
                    }
                }

                context.delete(dup)
            }
        }
        try context.save()
    }
    
    static func seedExercisesIfNeeded(in context: ModelContext) {
        do {
            let catalog: [ExerciseDTO] = try loadDTOCatalog(forResource: "exercises")

            for dto in catalog {
                try? upsertExercise(from: dto, in: context)
            }

            try context.save()
        } catch {
            print("Failed to seed exercises: \(error)")
            // Best-effort: ignore seeding errors in MVP
        }
    }
    
    static func consolidateDuplicateExercises(in context: ModelContext) throws {
        let all = try context.fetch(FetchDescriptor<Exercise>())
        let groups = Dictionary(grouping: all, by: { $0.id })  // logical key

        for (_, cluster) in groups where cluster.count > 1 {
            // Pick a primary; prefer the one that looks “best”
            // (use your own tie-breaker: dateModified, most relationships, etc.)
            guard let primary = cluster.max(by: { $0.workoutExercises.count < $1.workoutExercises.count }) else { continue }

            for dup in cluster where dup !== primary {
                // Merge fields
                primary.name = primary.name.count >= dup.name.count ? primary.name : dup.name
                primary.userPreferred = primary.userPreferred || dup.userPreferred

                // Merge relationships (union)
                for mg in dup.targettedMuscles where !primary.targettedMuscles.contains(mg) {
                    primary.targettedMuscles.append(mg)
                }

                // Re-home inverse relationships
                for wex in dup.workoutExercises {
                    wex.exercise = primary
                }

                // Remove the duplicate
                context.delete(dup)
            }
        }
        try context.save()
    }

    static func seedWorkoutPresetsIfNeeded(in context: ModelContext) {
        do {
            let catalog: [[WorkoutPresetDTO]] = try loadDTOCatalog(forResource: "workout-presets")

            for grouping in catalog {
                let groupId = UUID()
                for dto in grouping {
                    try? upsertPreset(from: dto, groupId: groupId, in: context)
                }
            }

            try context.save()
        } catch {
            print("Failed to seed workout presets: \(error)")
            // Best-effort: ignore seeding errors in MVP
        }
    }
        
    static func consolidateDuplicatePresets(in context: ModelContext) throws {
        let all = try context.fetch(FetchDescriptor<WorkoutPreset>())
        let groups = Dictionary(grouping: all, by: { $0.id })

        for (_, cluster) in groups where cluster.count > 1 {
            guard let primary = cluster.max(by: { $0.workouts.count < $1.workouts.count }) else { continue }

            for dup in cluster where dup !== primary {
                // Merge data
                primary.name = primary.name.count >= dup.name.count ? primary.name : dup.name
                // Union muscle groups
                for mg in dup.targettedMuscles where !primary.targettedMuscles.contains(mg) {
                    primary.targettedMuscles.append(mg)
                }

                // Re-home workouts
                for wk in dup.workouts {
                    wk.preset = primary
                }

                context.delete(dup)
            }
        }
        try context.save()
    }

    static func seedAllIfNeeded(in context: ModelContext) {
        seedMusclesIfNeeded(in: context)
        seedExercisesIfNeeded(in: context)
        seedWorkoutPresetsIfNeeded(in: context)
    }
    
    static func consolidateAllCatalogDuplicates(in context: ModelContext) {
        do {
            try consolidateDuplicateMuscleGroups(in: context)
            try consolidateDuplicateExercises(in: context)
            try consolidateDuplicatePresets(in: context)
        } catch {
            print("Consolidation failed: \(error)")
        }
    }
    
    static func consolidateAndSeedModels(in context: ModelContext) {
        consolidateAllCatalogDuplicates(in: context)
        seedAllIfNeeded(in: context)
    }


    static func deleteAll(in context: ModelContext) {
        try? context.delete(model: Workout.self)
        try? context.delete(model: WorkoutPreset.self)
        try? context.delete(model: WorkoutExercise.self)
        try? context.delete(model: Exercise.self)
        try? context.delete(model: MuscleGroup.self)
    }
    
    fileprivate static func loadDTOCatalog<DTO>(forResource resource: String) throws -> DTO where DTO: Decodable {
        if let url = Bundle.main.url(forResource: resource, withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let items = try? JSONDecoder().decode(DTO.self, from: data) {
            return items
        }
        // Fallback to built-in JSON so the app runs even without a bundled file.
        let data = Data(emptyJsonArrAsString.utf8)
        return try JSONDecoder().decode(DTO.self, from: data)
    }

    fileprivate static func resolveMuscles(_ ids: [String], in context: ModelContext) throws -> [MuscleGroup] {
        // 1) Preserve call-site order but ensure uniqueness
        var seen = Set<String>()
        let orderedUnique = ids.compactMap { id -> String? in
            guard !id.isEmpty, !seen.contains(id) else { return nil }
            seen.insert(id)
            return id
        }
        guard !orderedUnique.isEmpty else { return [] }

        // 2) Fetch everything we already have for those ids
        let fetched = try context.fetch(
            FetchDescriptor<MuscleGroup>(
                predicate: #Predicate { mg in orderedUnique.contains(mg.id) }
            )
        )
        
        // 3) Consolidate duplicates if there are any, and re-run the function
        //    It shouldn't need to consolidate duplicates more than once.
        if fetched.count > Set(fetched.map(\.id)).count {
            try consolidateDuplicateMuscleGroups(in: context)
            return try resolveMuscles(ids, in: context)
        }

        // 4) Create any missing ids
        var byId = Dictionary(uniqueKeysWithValues: fetched.map { ($0.id, $0) })
        for id in orderedUnique where byId[id] == nil {
            if let sup = MuscleGroup.Supported(rawValue: id) {
                byId[id] = try? upsertMuscleGroup(sup, in: context)
            } else {
                // For safety, we’ll just skip unknowns
                continue
            }
        }

        // 5) Return in the same order as requested
        return orderedUnique.compactMap { byId[$0] }
    }
    
    fileprivate static func upsertPreset(from dto: WorkoutPresetDTO, groupId: WorkoutPreset.GroupID? = nil, in context: ModelContext) throws {
        // 1) find by logical id (dataset id)
        let existing = try context.fetch(
            FetchDescriptor<WorkoutPreset>(
                predicate: #Predicate { $0.id == dto.datasetId }
            ))
            .sorted(by: { $0.groupId < $1.groupId })
            .first

        if let ex = existing {
            // 2) update
            ex.name = dto.name
            ex.groupId = groupId ?? ex.groupId
            ex.targettedMuscles = try resolveMuscles(dto.muscles, in: context)
        } else {
            // 3) insert
            let ex = WorkoutPreset(
                id: dto.datasetId,
                groupId: groupId ?? UUID(),
                name: dto.name,
                targeting: try resolveMuscles(dto.muscles, in: context)
            )
            context.insert(ex)
        }
    }

    private static func upsertExercise(from dto: ExerciseDTO, in context: ModelContext) throws {
        // 1) find by logical id (dataset id)
        let existing = try context.fetch(
            FetchDescriptor<Exercise>(
                predicate: #Predicate { $0.id == dto.datasetId }
            )
        ).first

        if let ex = existing {
            // 2) update
            ex.name = dto.name
            ex.userPreferred = ex.userPreferred
            ex.targettedMuscles = try resolveMuscles(dto.muscles, in: context)
        } else {
            // 3) insert
            let ex = Exercise(id: dto.datasetId, name: dto.name,
                              targettedMuscles: try resolveMuscles(dto.muscles, in: context))
            context.insert(ex)
        }
    }

    fileprivate static func upsertMuscleGroup(_ supported: MuscleGroup.Supported, in context: ModelContext) throws -> MuscleGroup {
        let raw = supported.rawValue

        // 1) Fetch any existing rows with this id (there may be duplicates in CloudKit mode)
        let existing = try context.fetch(
            FetchDescriptor<MuscleGroup>(
                predicate: #Predicate { $0.id == raw }
            )
        )

        // 2) If none exist, create + insert and return
        guard !existing.isEmpty else {
            let mg = MuscleGroup(supported)
            context.insert(mg)
            return mg
        }

        // 3) If exactly one, that’s our canonical instance
        if existing.count == 1, let only = existing.first {
            return only
        }

        // 4) Consolidate duplicates and return the insertion (it should exit at step 3.)
        try consolidateDuplicateMuscleGroups(in: context)
        return try upsertMuscleGroup(supported, in: context)
    }
}
