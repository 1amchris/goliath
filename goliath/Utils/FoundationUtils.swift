//
//  Utils.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-22.
//

import Foundation

extension Sequence {
    /// Groups elements of a sequence into a dictionary keyed by the result of a closure.
    ///
    /// - Parameter keyForValue: A closure that maps an element to a key.
    /// - Returns: A dictionary where the keys are the result of `keyForValue` and the values are arrays of elements.
    func group<Key: Hashable>(by keyForValue: (Element) -> Key) -> [Key: [Element]] {
        Dictionary(grouping: self, by: keyForValue)
    }
    
    /// Groups elements of a sequence into a dictionary keyed by a property.
    ///
    /// - Parameter keyPath: A key path to a property on each element to use as the dictionary key.
    /// - Returns: A dictionary where the keys are values of the property and the values are arrays of elements.
    func group<Key: Hashable>(by keyPath: KeyPath<Element, Key>) -> [Key: [Element]] {
        Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
    }

}

extension Dictionary {
    /// Converts a dictionary into an array of (key, value) tuples.
    ///
    /// Useful for iterating in SwiftUI `ForEach` when grouping collections.
    var items: [(key: Key, value: Value)] {
        map { (key: $0.key, value: $0.value) }
    }
}

extension Date: @retroactive Identifiable {
    public var id: Date { self }
}

extension Sequence where Element: Hashable {
    /// Returns an array containing only the unique elements,
    /// preserving their original order of appearance.
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return self.filter { seen.insert($0).inserted }
    }
}
