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
        
        if isSliding {
            // Checa se parou de dar Wall Slide
            
            // Condições de parada
            // Tocou no chão
            
            if physicsComp.isOnGround() {
                stopWallSlide()
            } else {
                adjustVelocityForWallSlide()
            }

        } else if physicsComp.isWallSliding(direction: movementComp.direction) {
            
            // Check se pode entrar em wall slide
            
            // Condição de entrada
            // Está tocando numa wall E não está tocando no chão
            startWallSlide()
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
        
        physicsComp.body.velocity.dy += -8
        physicsComp.body.velocity.dy.fixedMin(-100)
        physicsComp.body.velocity.dx = 0
    }

}

