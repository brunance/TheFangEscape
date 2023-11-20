//
//  TestComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 16/11/23.
//

import Foundation
import GameplayKit

class WallSlideComponent: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var movementComp: MovementComponent?
    weak var stateMachineComp: AnimationStateMachineComponent?
    
    private var isSliding: Bool = false
    
    override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
        movementComp = entity?.component(ofType: MovementComponent.self)
        stateMachineComp = entity?.component(ofType: AnimationStateMachineComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let physicsComp = physicsComp, let movementComp = movementComp else { return }
        
        if physicsComp.touchedOnWall(direction: movementComp.direction) && !physicsComp.isOnGround() {
            startWallSlide()
        } else if isSliding {
            stopWallSlide()
        }
        
        if isSliding {
            adjustVelocityForWallSlide()
        }
    }
    
    private func startWallSlide() {
        guard let stateMachine = stateMachineComp else {return}
        
        stateMachine.stateMachine.enter(WallSlide.self)
        isSliding = true
        
    }
    
    private func stopWallSlide() {
        isSliding = false
    }
    
    private func adjustVelocityForWallSlide() {
        guard let physicsComp = physicsComp else { return }
        
        physicsComp.body.velocity.dy -= physicsComp.body.velocity.dy * 0.3
        physicsComp.body.velocity.dx = 0
        
        // Verifique a saída da velocidade para depuração
        print(physicsComp.body.velocity.dy)
    }

}

