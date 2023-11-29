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
}

class MovementComponent: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var stateMachineComp: AnimationStateMachineComponent?
    weak var node: SKNode?
    
    var velocityX: CGFloat
    var direction: Direction
    
    private var hasChangedDirection = false
    private var isRunning = false
    
    public init(velocityX: CGFloat, direction: Direction) {
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
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let physicsComp = physicsComp else { return }
        
        moveNode()
        
        if physicsComp.touchedOnWall(direction: self.direction) && !hasChangedDirection && !physicsComp.isWallSliding(direction: self.direction) {
            changeDirection()
            hasChangedDirection = true
        } else if !physicsComp.touchedOnWall(direction: self.direction) {
            hasChangedDirection = false
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
        
        if (physicsComp.isOnGround() && physicsComp.body.velocity.dx != 0) {
            stateMachineComp?.stateMachine.enter(RunningState.self)
        } else {
            if physicsComp.body.velocity.dy < -10 {
                stateMachineComp?.stateMachine.enter(JumpingState.self)
            } else if physicsComp.body.velocity.dy > 10 {
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
    
    public func getDirection() -> CGFloat {
        return direction.rawValue
    }
    
    public func changeDirection() {
        self.direction = self.direction == .right ? .left : .right
    }
}
