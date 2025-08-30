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

extension Text {
    /// Returns a Text where all matches of `query` inside `string` are bolded.
    static func highlightMatches(in string: String, query: String) -> Text {
        guard !query.isEmpty else { return Text(string) }

        let lowercasedString = string.lowercased()
        let lowercasedQuery = query.lowercased()

        var result = Text("")
        var currentIndex = string.startIndex

        while let range = lowercasedString.range(of: lowercasedQuery, range: currentIndex..<string.endIndex) {
            // non-matching part
            if range.lowerBound > currentIndex {
                let prefix = String(string[currentIndex..<range.lowerBound])
                result = result + Text(prefix)
            }
            // matching part → bold
            let match = String(string[range])
            result = result + Text(match).bold()

            currentIndex = range.upperBound
        }

        // remaining part
        if currentIndex < string.endIndex {
            let suffix = String(string[currentIndex..<string.endIndex])
            result = result + Text(suffix)
        }

        return result
    }
}
