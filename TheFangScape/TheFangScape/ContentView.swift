//
//  ContentView.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 13/11/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var gameScene: GameScene {
        return GameScene(size: .init(width: 1000, height: 1000))
    }
    
    var body: some View {
        #if DEBUG
        SpriteView(scene: gameScene,
                   debugOptions: [
                    .showsPhysics,
                   ]).ignoresSafeArea()
        #else
        SpriteView(scene: gameScene).ignoresSafeArea()
        #endif
        
    }
}

//#Preview {
//    ContentView()
//}
