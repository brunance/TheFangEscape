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
    }
    
    public func jump() {
        
        guard let physicsComp = physicsComp else { return }
        
        if (physicsComp.isOnGround()) {
            physicsComp.body.applyImpulse(.init(dx: 0, dy: forceY))
        }
        
    }
    
}
