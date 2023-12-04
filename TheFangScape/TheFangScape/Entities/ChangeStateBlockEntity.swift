//
//  ChangeStateBlockEntity.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 17/11/23.
//

import Foundation
import GameplayKit

public enum Status: CGFloat {
    case active = 1.0
    case desactive = -1.0
}

public class ChangeStateBlockEntity: BlockEntity {
    
    var status: Status
    
    public init(position: CGPoint = .zero, size: CGSize, status: Status) {
        self.status = status
        super.init(position: position, size: size)
        
        guard let physicsComp = self.component(ofType: PhysicsComponent.self),
              let node = self.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode
        else { return }
        
        let changeStateComp = ChangeStateComponent(firstState: {
            node.alpha = 1
            node.texture = SKTexture(imageNamed: "changeEnabled0")
            physicsComp.isActive()
        }, secondState: {
            node.alpha = 0.4
            node.texture = SKTexture(imageNamed: "changeDisabled0")
            physicsComp.isActive(false)
        }, isFirstState: status)

        self.addComponent(changeStateComp)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observeJump), name: .jumped, object: nil)
    }
    
    @objc
    private func observeJump() {
        component(ofType: ChangeStateComponent.self)?.toogleState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
