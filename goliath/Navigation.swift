//
//  Navigation.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import Foundation

final class NavCoordinator: ObservableObject {
    @Published var path: [Route] = []
}

enum Route: Hashable {
    case workoutDetail(UUID)
    case draft(UUID)
    case review(UUID)
    case doExercise(UUID, UUID) // (workoutId, workoutExerciseId)
}

