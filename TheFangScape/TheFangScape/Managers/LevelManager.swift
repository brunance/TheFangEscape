//
//  LevelManager.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 30/11/23.
//

import Foundation

public class LevelManager {
    public static let shared = LevelManager()
    
    private init() { 
        currentLevelIndex = 1
    }
    
    public var currentLevelName: String {
        return "level\(currentLevelIndex)"
    }
    
    private var currentLevelIndex: Int
    
    public func nextLevel() {
        currentLevelIndex += 1
    }
    
    public func setLevel(index: Int) {
        currentLevelIndex = index
    }
}
