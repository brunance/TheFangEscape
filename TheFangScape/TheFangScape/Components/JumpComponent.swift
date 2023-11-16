//
//  JumpComponent.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 14/11/23.
//

import Foundation
import GameplayKit

public class JumpComponent: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var movementComp: MovementComponent?
    
    var forceY: CGFloat
    var forceX: CGFloat
    
    public init(forceY: CGFloat, forceX: CGFloat) {
        self.forceY = forceY
        self.forceX = forceX
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
        movementComp = entity?.component(ofType: MovementComponent.self)
    }
    
    public func jump() {
        
        guard let physicsComp = physicsComp, let movementComp = movementComp else { return }
        
        if (physicsComp.isOnGround()) {
            physicsComp.body.applyImpulse(.init(dx: 0, dy: forceY))
        } else if physicsComp.isWallSlinding(direction: movementComp.direction) {
            performWallJump()
        }
        
    }
    
    private func performJump() {
        physicsComp?.body.applyImpulse(CGVector(dx: forceX, dy: forceY))
    }
    
    private func performWallJump() {
        guard let physicsComp = physicsComp, let movementComp = movementComp else { return }
        
        let wallJumpVelocityX: CGFloat = 700.0
        let wallJumpVelocityY: CGFloat = 700.0
        
        physicsComp.body.velocity = CGVector(dx: movementComp.direction.rawValue * wallJumpVelocityX, dy: wallJumpVelocityY)
        
        movementComp.changeDirection()
    }
}
