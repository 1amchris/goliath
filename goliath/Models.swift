//
//  Models.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftData
import Foundation

@Model
class Workout: Identifiable, Equatable {
    @Attribute(.unique) var id: UUID
    var dateCompleted: Date
    var dateModified: Date
    var isDraft: Bool

    @Relationship(deleteRule: .nullify, inverse: \WorkoutPreset.workouts)
    var preset: WorkoutPreset? = nil

    @Relationship(deleteRule: .cascade, inverse: \WorkoutExercise.workout)
    var _exercises: [WorkoutExercise] = []
    var exercises: [WorkoutExercise] {
        get { _exercises.sorted { $0._order < $1._order } }
        set { _exercises = newValue }
    }

    init(isDraft: Bool = true) {
        self.id = UUID()
        self.dateCompleted = Date()
        self.dateModified = Date()
        self.isDraft = isDraft
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool { lhs.id == rhs.id }
}

@Model
class WorkoutExercise: Identifiable, Equatable {
    @Attribute(.unique) var id: UUID
    var exercise: Exercise
    var name: String { exercise.name }
    var targettedMuscles: [MuscleGroup] { exercise.targettedMuscles }
    
    var _order: Int

    var _repsJSON: String = "[]"
    var reps: [Int] {
        get { (try? JSONDecoder().decode([Int].self, from: Data(_repsJSON.utf8))) ?? [] }
        set { _repsJSON = (try? String(data: JSONEncoder().encode(newValue), encoding: .utf8)) ?? "[]" }
    }
    var completedSets: Int { reps.count }

    var workout: Workout

    init(exercise: Exercise, workout: Workout, order: Int) {
        self.id = UUID()
        self.exercise = exercise
        self.workout = workout
        self._order = order
    }
    
    static func == (lhs: WorkoutExercise, rhs: WorkoutExercise) -> Bool { lhs.id == rhs.id }
}

@Model
class Exercise: Identifiable, Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var userPreferred: Bool = false

    @Relationship(inverse: \MuscleGroup.exercises)
    var targettedMuscles: [MuscleGroup] = []

    @Relationship(deleteRule: .cascade, inverse: \WorkoutExercise.exercise)
    var workoutExercises: [WorkoutExercise] = []

    init(id: String, name: String, targettedMuscles: [MuscleGroup] = []) {
        self.id = id
        self.name = name
        self.targettedMuscles = targettedMuscles
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool { lhs.id == rhs.id }
}

@Model
class WorkoutPreset: Identifiable, Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var groupId: UUID
    
    @Relationship(inverse: \MuscleGroup.presets)
    var targettedMuscles: [MuscleGroup] = []

    var workouts: [Workout] = []
    
    init(id: String, groupId: UUID, name: String, targeting muscleGroups: [MuscleGroup]) {
        self.id = id
        self.groupId = groupId
        self.name = name
        self.targettedMuscles = muscleGroups
    }
    
    static func == (lhs: WorkoutPreset, rhs: WorkoutPreset) -> Bool { lhs.id == rhs.id }
}

@Model
class MuscleGroup: Identifiable, Equatable {
    typealias ID = String

    enum Supported: String, CaseIterable {
        case abdominals
        case abductors
        case adductors
        case biceps
        case calves
        case forearms
        case glutes
        case hamstrings
        case laterals
        case lumbars
        case neck
        case obliques
        case pectorals
        case quadriceps
        case deltoids
        case trapezii
        case triceps
    }

    @Attribute(.unique)
    var id: String
    
    var exercises: [Exercise] = []
    
    var presets: [WorkoutPreset] = []
    
    init(_ id: Supported, exercises: [Exercise] = []) {
        self.id = id.rawValue
        self.exercises = exercises
    }
    
    static func == (lhs: MuscleGroup, rhs: MuscleGroup) -> Bool { lhs.id == rhs.id }
}
