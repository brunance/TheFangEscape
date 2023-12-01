//
//  RoomSelectionView.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import SwiftUI
import SpriteKit

public struct RoomSelectionView: View {
    
    @State var willMoveToGameScene = false

    func roomScene(size: CGSize) -> RoomSelectionScene {
        return RoomSelectionScene(size: size, view: self)
    }
    
    public var body: some View {
        if willMoveToGameScene {
            ContentView()
        } else {
            
            GeometryReader { geo in
                SpriteView(scene: roomScene(size: geo.size))
                    .ignoresSafeArea()
            }
        }
    }
    
    public func selectedRoom(index: Int) {
        LevelManager.shared.setLevel(index: index)
        self.willMoveToGameScene = true
    }
}

#Preview {
    RoomSelectionView()
}
