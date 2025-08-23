//
//  AllCoronals.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-19.
//

import SwiftUI

extension MusculoDiagramsView {
    struct AllCoronals: View {
        private let muscleGroups: [MusculoDiagramsView.MuscleGroup]

        init(presenting muscleGroups: [MusculoDiagramsView.MuscleGroup]) {
            let allUniqueGroups = Set(muscleGroups + MusculoDiagramsView.MuscleGroup.allCases)
            self.muscleGroups = Array(allUniqueGroups)
        }

        var body: some View {
            HStack {
                MusculoDiagramsView.AnteriorCoronal(presenting: muscleGroups)
                MusculoDiagramsView.PosteriorCoronal(presenting: muscleGroups)
            }
        }
    }
}

#if DEBUG
#Preview {
    MusculoDiagramsView.AllCoronals(presenting: [
        .abdominals { print("abdominals") },
        .abductors { print("abductors") },
        .adductors { print("adductors") },
        .biceps { print("biceps") },
        .calves { print("calves") },
        .deltoids { print("deltoids") },
        .forearms { print("forearms") },
        .glutes { print("glutes") },
        .hamstrings { print("hamstrings") },
        .laterals { print("laterals") },
        .lumbars { print("lumbars") },
        .neck { print("neck") },
        .obliques { print("obliques") },
        .pectorals { print("pectorals") },
        .quadriceps { print("quads") },
        .trapezii { print("trapezii") },
        .triceps { print("triceps") },
    ])
}
#endif
