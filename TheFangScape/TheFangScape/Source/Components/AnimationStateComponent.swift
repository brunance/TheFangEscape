//
//  AnimationStateComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 16/11/23.
//

import Foundation
import SpriteKit
import GameplayKit

class AnimationStateMachineComponent: GKComponent {
    
    var stateMachine: GKStateMachine
    
    init(stateMachine : GKStateMachine) {
        self.stateMachine = stateMachine
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
