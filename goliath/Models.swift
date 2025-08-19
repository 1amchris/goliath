//
//  Entities.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftData
import Foundation

@Model
class Workout {
    @Attribute(.unique) var id: UUID
    var dateCreated: Date
    var dateModified: Date
    var preset: PresetType
    var exercises: [WorkoutExercise]
    var isDraft: Bool

    init(preset: PresetType, isDraft: Bool = true) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()
        self.preset = preset
        self.exercises = []
        self.isDraft = isDraft
    }
}

@Model
class WorkoutExercise {
    @Attribute(.unique) var id: UUID
    var exercise: Exercise
    var order: Int
    var completedCount: Int

    init(exercise: Exercise, order: Int, completedCount: Int = 1) {
        self.id = UUID()
        self.exercise = exercise
        self.order = order
        self.completedCount = completedCount
    }
}

@Model
class Exercise {
    @Attribute(.unique) var id: UUID
    var name: String
    var presets: [PresetType] // many-to-many via enum list (MVP)

    init(name: String, presets: [PresetType]) {
        self.id = UUID()
        self.name = name
        self.presets = presets
    }
}

enum PresetType: String, Codable, CaseIterable {
    case fullBody, upperBody, lowerBody, chest, legs, arms, back, core
}
