//
//  MovementComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 15/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public enum PlayerDirection: CGFloat {
    case left = -1.0
    case right = 1.0
}

class MovementComponent: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var stateMachineComp: AnimationStateMachineComponent?
    
    var velocityX: CGFloat
    var direction: PlayerDirection
    
    private var hasChangedDirection = false
    private var isRunning = false
    
    public init(velocityX: CGFloat, direction: PlayerDirection) {
        self.velocityX = velocityX
        self.direction = direction
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
        stateMachineComp = entity?.component(ofType: AnimationStateMachineComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let physicsComp = physicsComp else { return }
        
        moveNode()
        
        if entity is PlayerEntity {
            if physicsComp.touchedOnWall(direction: self.direction) && !hasChangedDirection && !physicsComp.isWallSliding(direction: self.direction) {
                changeDirection()
                hasChangedDirection = true
            } else if !physicsComp.touchedOnWall(direction: self.direction) {
                hasChangedDirection = false
            }
        } else {
            if physicsComp.touchedOnWall(direction: self.direction) && !hasChangedDirection {
                changeDirection()
                hasChangedDirection = true
            } else if !physicsComp.touchedOnWall(direction: self.direction) {
                hasChangedDirection = false
            }
        }
        
        if !isRunning {
            isRunning.toggle()
        } else if !physicsComp.isOnGround() {
            isRunning = false
        }
        
    }
    
    func verifyAnimation() {
        guard let physicsComp = physicsComp ,
            !physicsComp.isWallSliding(direction: self.direction) else { return }
        
        if physicsComp.body.velocity.dy < -0.5 {
            stateMachineComp?.stateMachine.enter(Jump.self)
            print("FALL STATE")
        } else if physicsComp.body.velocity.dy > 0.5 {
            stateMachineComp?.stateMachine.enter(Jump.self)
            print("JUMP STATE")
        } else if physicsComp.body.velocity.dx != 0 {
            stateMachineComp?.stateMachine.enter(Run.self)
            print("RUN STATE")
        }
    }
    
    func moveNode() {
        guard let physicsComp = physicsComp else { return }
        physicsComp.body.velocity.dx = velocityX * getDirection()
        
        entity?.component(ofType: GKSKNodeComponent.self)?.node.xScale = getDirection()
        
        verifyAnimation()
    }
    
    public func getDirection() -> CGFloat {
        return direction.rawValue
    }
    
    public func getPlayerDirection() -> PlayerDirection {
        return direction
    }
    
    public func changeDirection() {
        self.direction = self.direction == .right ? .left : .right
    }
}
