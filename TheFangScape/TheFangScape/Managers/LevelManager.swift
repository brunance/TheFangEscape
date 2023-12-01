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
        currentFloorIndex = 1
    }
    
    public var currentLevelName: String {
        return "\(currentFloorName)-level\(currentLevelIndex)"
    }
    
    public var currentFloorName: String {
        return "floor\(currentFloorIndex)"
    }
    
    private var currentLevelIndex: Int
    private var currentFloorIndex: Int
    
    public func nextLevel() {
        currentLevelIndex += 1
    }
    
    public func setLevel(index: Int) {
        currentLevelIndex = index
    }
    
    public func setFloor(index: Int) {
        currentFloorIndex = index
    }
}
