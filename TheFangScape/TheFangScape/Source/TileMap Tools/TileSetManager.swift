//
//  TileSetManager.swift
//  Chiko Liru
//
//  Created by Victor Vasconcelos on 19/10/23.
//

import Foundation

public class TileSetManager {
    public static let shared = TileSetManager()
    
    public var groundSetData: TileSetData?
    
    private init() {
        groundSetData = loadTileSetData(named: "Ground")
    }
    
    public func loadTileSetData(named: String) -> TileSetData? {
        if let path = Bundle.main.path(forResource: named, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let tileSetData = try JSONDecoder().decode(TileSetData.self, from: data)
                return tileSetData
                
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    
    public func loadScenarioData(named: String) -> LevelData? {
        if let path = Bundle.main.path(forResource: named, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let levelData = try JSONDecoder().decode(LevelData.self, from: data)
                return levelData
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
}
