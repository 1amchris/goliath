//
//  ViewUtils.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        if condition { transform(self) } else { self }
    }
}

