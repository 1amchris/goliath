//
//  SampleDataLoader.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import SwiftUI
import SwiftData

struct SampleDataLoader {
    static func loadSampleData(context: ModelContext) {
        // Clear old data for demo
        try? context.delete(model: Workout.self)
        try? context.delete(model: WorkoutExercise.self)
        try? context.delete(model: Exercise.self)
        
        // Create some exercises
        let squat = Exercise(name: "Squat", presets: [.fullBody, .legs, .lowerBody])
        let benchPress = Exercise(name: "Bench Press", presets: [.fullBody, .upperBody, .chest, .arms])
        let deadlift = Exercise(name: "Deadlift", presets: [.fullBody, .legs, .lowerBody, .back])
        let plank = Exercise(name: "Plank", presets: [.core, .fullBody])
        
        context.insert(squat)
        context.insert(benchPress)
        context.insert(deadlift)
        context.insert(plank)
        
        // Create workout exercises
        let squatSet = WorkoutExercise(exercise: squat, order: 0, completedCount: 3)
        let benchSet = WorkoutExercise(exercise: benchPress, order: 1, completedCount: 3)
        let deadliftSet = WorkoutExercise(exercise: deadlift, order: 2, completedCount: 2)
        let plankSet = WorkoutExercise(exercise: plank, order: 3, completedCount: 2)
        
        context.insert(squatSet)
        context.insert(benchSet)
        context.insert(deadliftSet)
        context.insert(plankSet)
        
        // Create workouts
        let workout1 = Workout(preset: .fullBody, isDraft: false)
        workout1.exercises = [squatSet, benchSet, deadliftSet]
        
        let workout2 = Workout(preset: .core, isDraft: false)
        workout2.exercises = [plankSet]
        
        context.insert(workout1)
        context.insert(workout2)
        
        try? context.save()
    }
}
