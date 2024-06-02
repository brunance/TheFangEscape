//
//  LevelManager.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 30/11/23.
//

import Foundation

public class LevelManager {
    
    public static let shared = LevelManager()
    
    private var savedLevelIndex: Int
    private var savedFloorIndex: Int
    
    private let saveURL: URL
    
    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.saveURL = documentsDirectory.appendingPathComponent("levelManagerData.json")
        
        if let savedData = try? Data(contentsOf: saveURL),
           let savedLevels = try? JSONDecoder().decode(SavedLevels.self, from: savedData) {
            savedLevelIndex = savedLevels.level
            savedFloorIndex = savedLevels.floor
        } else {
            savedLevelIndex = 1
            savedFloorIndex = 1
            saveState()
        }
    }
    
    public var currentLevelName: String {
        return "\(currentFloorName)-level\(savedLevelIndex)"
    }
    
    public var currentFloorName: String {
        return "floor\(savedFloorIndex)"
    }
    
    public func nextLevel() {
        if savedLevelIndex == 12 {
            savedLevelIndex = 1
            savedFloorIndex += 1
        } else {
            savedLevelIndex += 1
        }
        
        saveState()
    }
    
    public func setLevel(index: Int) {
        savedLevelIndex = index
        saveState()
    }
    
    public func setFloor(index: Int) {
        savedFloorIndex = index
        saveState()
    }
    
    public func getLevel() -> Int {
        return savedLevelIndex
    }
    
    public func getFloor() -> Int {
        return savedFloorIndex
    }
    
    private func saveState() {
        let savedLevels = SavedLevels(level: savedLevelIndex, floor: savedFloorIndex)
        
        if let encodedData = try? JSONEncoder().encode(savedLevels) {
            try? encodedData.write(to: saveURL)
        }
    }
    
    private func resetProgress() {
        savedFloorIndex = 1
        savedLevelIndex = 1
        
        saveState()
    }
    
    private struct SavedLevels: Codable {
        let level: Int
        let floor: Int
    }
}
