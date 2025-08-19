//
//  Item.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-18.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
