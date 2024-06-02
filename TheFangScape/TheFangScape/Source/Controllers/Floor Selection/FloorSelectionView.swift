//
//  FloorSelectionView.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import SwiftUI
import SpriteKit

public struct FloorSelectionView: View {
    
    var floorScene: FloorSelectionScene {
        return FloorSelectionScene(size: .init(width: 1920, height: 1080), view: self)
    }
    
    @State var willMoveToRoomSelection = false
    
    @State var selectedIndex: Int = 0
    
    public var body: some View {
        if !willMoveToRoomSelection {
            SpriteView(scene: floorScene).ignoresSafeArea()
        } else {
            RoomSelectionView()
        }
    }
    
    public func selectedFloor(index: Int) {
        willMoveToRoomSelection = true
        selectedIndex = index
        LevelManager.shared.setFloor(index: index)
    }
}
