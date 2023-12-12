//
//  LevelManager.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 30/11/23.
//

import Foundation

public class LevelManager {
    public static let shared = LevelManager()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
        if let savedLevelIndex = userDefaults.value(forKey: "currentLevelIndex") as? Int,
           let savedFloorIndex = userDefaults.value(forKey: "currentFloorIndex") as? Int {
            currentLevelIndex = savedLevelIndex
            currentFloorIndex = savedFloorIndex
        } else {
            currentLevelIndex = 1
            currentFloorIndex = 1
        }
    }
    
    public var currentLevelName: String {
        return "\(currentFloorName)-level\(currentLevelIndex)"
    }
    
    public var currentFloorName: String {
        return "floor\(currentFloorIndex)"
    }
    
    internal var currentLevelIndex: Int {
        didSet {
            userDefaults.setValue(currentLevelIndex, forKey: "currentLevelIndex")
            userDefaults.synchronize()
        }
    }
    
    internal var currentFloorIndex: Int {
        didSet {
            userDefaults.setValue(currentFloorIndex, forKey: "currentFloorIndex")
            userDefaults.synchronize()
        }
    }
    
    public func nextLevel() {
        currentLevelIndex += 1
    }
    
    public func setLevel(index: Int) {
        if index > currentLevelIndex {
            currentLevelIndex = index
        }
    }
    
    public func setFloor(index: Int) {
        if index > currentFloorIndex {
            currentFloorIndex = index
        }
    }
}
