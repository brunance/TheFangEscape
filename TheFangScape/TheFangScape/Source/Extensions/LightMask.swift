//
//  LightMask.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 18/11/23.
//

import Foundation
import SpriteKit

public class LightMask {
    static let base: UInt32 = 0b1
    static let enviroment = LightMask.base << 0
    static let torch = LightMask.base << 1
    
    static var allMasks: [UInt32] = [
        LightMask.enviroment,
        LightMask.torch,
    ]
    
    static func contactWithAllCategories(less: [UInt32] = []) -> UInt32 {
        var result: UInt32 = 0b00
        
        for category in LightMask.allMasks {
            if !less.contains(category) {
                result |= category
            }
        }
        
        return result
    }
}
