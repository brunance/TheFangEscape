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
        return GameScene(size: .init(width: 1080, height: 1920))
    }
    
    var body: some View {
        SpriteView(scene: gameScene).ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
