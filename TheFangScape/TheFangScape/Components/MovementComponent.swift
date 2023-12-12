//
//  MovementComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 15/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public enum Direction: CGFloat {
    case left = -1.0
    case right = 1.0
    
    var value: CGFloat {
        rawValue
    }
}

enum EntityType {
    case gravityAffected
    case nonGravityAffected
}

class MovementComponent: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var stateMachineComp: AnimationStateMachineComponent?
    weak var node: SKNode?
    
    var velocityX: CGFloat
    var direction: Direction
    var entityType: EntityType
    
    private var hasChangedDirection = false
    private var isDead = false
    
    init(velocityX: CGFloat, direction: Direction, entityType: EntityType) {
        self.velocityX = velocityX
        self.direction = direction
        self.entityType = entityType
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
        stateMachineComp = entity?.component(ofType: AnimationStateMachineComponent.self)
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        if !isDead {
            moveNode()
            
            if entityType == .gravityAffected {
                handleGravityAffectedEntity()
            } else if entityType == .nonGravityAffected {
                handleNonGravityAffectedEntity()
            }
        }
    }
    
    func verifyAnimation() {
        guard let physicsComp = physicsComp, !physicsComp.isWallSliding(direction: direction) else { return }
        
        if physicsComp.isOnGround() && physicsComp.body.velocity.dx != 0 {
            stateMachineComp?.stateMachine.enter(RunningState.self)
        } else {
            if physicsComp.body.velocity.dy < -10 || physicsComp.body.velocity.dy > 10 {
                stateMachineComp?.stateMachine.enter(JumpingState.self)
            }
        }
    }
    
    func moveNode() {
        guard let physicsComp = physicsComp else { return }
        physicsComp.body.velocity.dx = velocityX * getDirection()
        
        node?.xScale = getDirection()
        
        verifyAnimation()
    }
    
    private func handleGravityAffectedEntity() {
        guard let physicsComp = physicsComp else { return }
        
        if physicsComp.touchedOnWall(direction: direction) == true &&
            !hasChangedDirection &&
            !physicsComp.isWallSliding(direction: direction) {
            changeDirection()
            hasChangedDirection = true
        } else if !physicsComp.touchedOnWall(direction: direction) {
            hasChangedDirection = false
        }
    }
    
    private func handleNonGravityAffectedEntity() {
        guard let physicsComp = physicsComp else { return }
        
        if physicsComp.hasContactWithOtherBody(direction: direction){
            changeDirection()
        }
    }
    
    public func getDirection() -> CGFloat {
        return direction.value
    }
    
    public func changeDirection() {
        direction = (direction == .right) ? .left : .right
    }
    
    public func toggleDeath() {
        isDead.toggle()
    }
}
