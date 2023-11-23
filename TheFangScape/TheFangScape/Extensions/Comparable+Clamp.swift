//
//  Comparable+Clamp.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 23/11/23.
//

import Foundation

extension Comparable {
    mutating func clamp(_ minimum: Self, _ maximum: Self) {
        self = Swift.min(Swift.max(self, minimum), maximum)
    }
    
    mutating func fixedMin(_ minimum: Self) {
        self = max(self, minimum)
    }
}
