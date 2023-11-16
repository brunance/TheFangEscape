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
    
    var velocityX: CGFloat
    var direction: PlayerDirection = .right
    
    private var hasChangedDirection = false
    
    public init(velocityX: CGFloat) {
        self.velocityX = velocityX
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let physicsComp = physicsComp else { return }

        moveNode()


        if physicsComp.touchedOnWall(direction: self.direction) && !hasChangedDirection && !physicsComp.isWallSlinding(direction: self.direction) {
            changeDirection()
            hasChangedDirection = true
        } else if !physicsComp.touchedOnWall() {
            hasChangedDirection = false
        }
    }
    
    func moveNode() {
        guard let physicsComp = physicsComp else { return }
        
        var velocity = physicsComp.body.velocity
        
        switch direction {
        case .left:
            velocity.dx = -velocityX
        case .right:
            velocity.dx = velocityX
        }
        
        physicsComp.body.velocity = velocity
    }
    
    public func getDirection() -> CGFloat {
        return direction.rawValue
    }
    
    public func changeDirection() {
        switch direction {
        case .left:
            self.direction = .right
        case .right:
            self.direction = .left
        }
    }
}
