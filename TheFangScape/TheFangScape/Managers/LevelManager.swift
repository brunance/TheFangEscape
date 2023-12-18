//
//  LevelManager.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 30/11/23.
//

import Foundation

public class LevelManager {
    
    public static let shared = LevelManager()
    
    private var currentLevelIndex: Int
    private var currentFloorIndex: Int
    
    private let saveURL: URL
    
    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.saveURL = documentsDirectory.appendingPathComponent("levelManagerData.json")
        
        if let savedData = try? Data(contentsOf: saveURL),
           let savedLevels = try? JSONDecoder().decode(SavedLevels.self, from: savedData) {
            currentLevelIndex = savedLevels.level
            currentFloorIndex = savedLevels.floor
        } else {
            currentLevelIndex = 1
            currentFloorIndex = 1
            saveState()
        }
    }
    
    public var currentLevelName: String {
        return "\(currentFloorName)-level\(currentLevelIndex)"
    }
    
    public var currentFloorName: String {
        return "floor\(currentFloorIndex)"
    }
    
    public func nextLevel() {
        if currentLevelIndex == 12 {
            currentLevelIndex = 1
            currentFloorIndex += 1
        } else {
            currentLevelIndex += 1
        }
        
        saveState()
    }
    
    public func setLevel(index: Int) {
        currentLevelIndex = index
        saveState()
    }
    
    public func setFloor(index: Int) {
        currentFloorIndex = index
        saveState()
    }
    
    public func getLevel() -> Int {
        return currentLevelIndex
    }
    
    public func getFloor() -> Int {
        return currentFloorIndex
    }
    
    private func saveState() {
        let savedLevels = SavedLevels(level: currentLevelIndex, floor: currentFloorIndex)
        
        if let encodedData = try? JSONEncoder().encode(savedLevels) {
            try? encodedData.write(to: saveURL)
        }
    }
    
    private func resetProgress() {
        currentFloorIndex = 1
        currentLevelIndex = 1
        
        saveState()
    }
    
    private struct SavedLevels: Codable {
        let level: Int
        let floor: Int
    }
}
