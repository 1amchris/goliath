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
    /* @Attribute(.unique) */
    var id: UUID = UUID()
    
    var title: String = Workout.EMPTY_TITLE
    var dateCompleted: Date = Date.now
    var dateModified: Date = Date.now
    var isDraft: Bool = false

    @Relationship(deleteRule: .nullify, inverse: \WorkoutPreset._workouts)
    var preset: WorkoutPreset? = nil

    @Relationship(deleteRule: .cascade, inverse: \WorkoutExercise.workout)
    var _exercises: [WorkoutExercise]? = []
    var exercises: [WorkoutExercise] {
        get { (_exercises ?? []).sorted { $0._order < $1._order } }
        set { _exercises = newValue }
    }

    init(title: String = "", isDraft: Bool = true) {
        self.id = UUID()
        self.title = !title.isEmpty ? title : Workout.EMPTY_TITLE
        self.dateCompleted = Date()
        self.dateModified = Date()
        self.isDraft = isDraft
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool { lhs.id == rhs.id }
    
    static let EMPTY = Workout()
    static private let EMPTY_TITLE = "Untitled"
    
    func reevaluateTitleIfNeeded() {
        guard let p = preset, title == Workout.EMPTY_TITLE else { return }
        title = "\(p.name) Workout"
    }
}

@Model
class WorkoutExercise: Identifiable, Equatable {
    /* @Attribute(.unique) */
    var id: UUID = UUID()
    
    var exercise: Exercise? = nil
    var name: String { exercise?.name ?? Exercise.EMPTY.name }
    var targettedMuscles: [MuscleGroup] { exercise?.targettedMuscles ?? Exercise.EMPTY.targettedMuscles }
    
    var _order: Int = Int.min

    var _repsJSON: String = "[]"
    var reps: [Int] {
        get { (try? JSONDecoder().decode([Int].self, from: Data(_repsJSON.utf8))) ?? [] }
        set { _repsJSON = (try? String(data: JSONEncoder().encode(newValue), encoding: .utf8)) ?? "[]" }
    }
    var completedSets: Int { reps.count }

    var workout: Workout? = nil

    init(exercise: Exercise, workout: Workout, order: Int) {
        self.id = UUID()
        self.exercise = exercise
        self.workout = workout
        self._order = order
    }
    
    static func == (lhs: WorkoutExercise, rhs: WorkoutExercise) -> Bool { lhs.id == rhs.id }
    
    static let EMPTY = WorkoutExercise(exercise: Exercise.EMPTY, workout: Workout.EMPTY, order: Int.min)
}

@Model
class Exercise: Identifiable, Equatable {
    /* @Attribute(.unique) */
    var id: String = UUID().uuidString
    
    var name: String = Exercise.EMPTY_NAME
    var userPreferred: Bool = false
    
    @Relationship(inverse: \MuscleGroup._exercises)
    var _targettedMuscles: [MuscleGroup]? = []
    var targettedMuscles: [MuscleGroup] {
        get { _targettedMuscles ?? [] }
        set { _targettedMuscles = newValue }
    }
    
    @Relationship(deleteRule: .cascade, inverse: \WorkoutExercise.exercise)
    var _workoutExercises: [WorkoutExercise]? = []
    var workoutExercises: [WorkoutExercise] {
        get { _workoutExercises ?? [] }
        set { _workoutExercises = newValue }
    }
    
    init(id: String, name: String, targettedMuscles: [MuscleGroup] = []) {
        self.id = id
        self.name = name
        self.targettedMuscles = targettedMuscles
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool { lhs.id == rhs.id }

    static let EMPTY = Exercise(id: Exercise.EMPTY_ID, name: Exercise.EMPTY_NAME)
    static private let EMPTY_ID = "NULL"
    static private let EMPTY_NAME = "Undefined"
}

@Model
class WorkoutPreset: Identifiable, Equatable {
    /* @Attribute(.unique) */
    var id: String = UUID().uuidString
    
    var name: String = WorkoutPreset.EMPTY_NAME
    
    var groupId: GroupID = UUID()
    
    @Relationship(inverse: \MuscleGroup._presets)
    var _targettedMuscles: [MuscleGroup]? = []
    var targettedMuscles: [MuscleGroup] {
        get { _targettedMuscles ?? [] }
        set { _targettedMuscles = newValue }
    }

    var _workouts: [Workout]? = []
    var workouts: [Workout] {
        get { _workouts ?? [] }
        set { _workouts = newValue }
    }
    
    init(id: String, groupId: GroupID, name: String, targeting muscleGroups: [MuscleGroup]) {
        self.id = id
        self.groupId = groupId
        self.name = name
        self.targettedMuscles = muscleGroups
    }
    
    static func == (lhs: WorkoutPreset, rhs: WorkoutPreset) -> Bool { lhs.id == rhs.id }
    
    static let EMPTY = WorkoutPreset(id: WorkoutPreset.EMPTY_ID, groupId: UUID(), name: WorkoutPreset.EMPTY_NAME, targeting: [])
    static private let EMPTY_ID = "NULL"
    static private let EMPTY_NAME = "Undefined"
    
    typealias ID = String
    typealias GroupID = UUID
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

    /* @Attribute(.unique) */
    var id: String = UUID().uuidString
    
    var _exercises: [Exercise]? = []
    var exercises: [Exercise] {
        get { _exercises ?? [] }
        set { _exercises = newValue }
    }

    var _presets: [WorkoutPreset]? = []
    var presets: [WorkoutPreset] {
        get { _presets ?? [] }
        set { _presets = newValue }
    }

    init(_ id: Supported, exercises: [Exercise] = []) {
        self.id = id.rawValue
        self.exercises = exercises
    }
    
    static func == (lhs: MuscleGroup, rhs: MuscleGroup) -> Bool { lhs.id == rhs.id }
}
