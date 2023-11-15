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
    
    var forceY: CGFloat
    var forceX: CGFloat
    var direction: Direction = .right
    
    private var hasChangedDirection = false
    
    public init(forceY: CGFloat, forceX: CGFloat) {
        self.forceY = forceY
        self.forceX = forceX
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

        if physicsComp.touchedOnWall(direction: self.direction) && !hasChangedDirection {
            changeDirection()
            hasChangedDirection = true
        } else if !physicsComp.touchedOnWall(direction: self.direction) {
            hasChangedDirection = false
        }
    }

    
    func moveNode() {
        guard let physicsComp = physicsComp else { return }
        
        switch direction {
        case .left:
            physicsComp.body.applyImpulse(CGVector(dx: -forceX, dy: 0))
        case .right:
            physicsComp.body.applyImpulse(CGVector(dx: forceX, dy: 0))
        }
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
