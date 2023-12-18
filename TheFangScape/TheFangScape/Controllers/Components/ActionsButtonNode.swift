//
//  ActionsButtonNode.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 18/12/23.
//

import Foundation
import SpriteKit

public class ActionsButtonNode: SKNode {
    
    var image =  SKSpriteNode(imageNamed: "buttonBackground")
    var imagePressed = SKSpriteNode(imageNamed: "buttonBackgroundPressed")
    var icon: SKSpriteNode
    var pressedAction: (() -> Void)?
    var releasedAction: (() -> Void)?
    
    init(icon: String, pressedAction: ( () -> Void)? = nil, releasedAction: ( () -> Void)? = nil) {
        self.icon = SKSpriteNode(imageNamed: icon)
        self.pressedAction = pressedAction
        self.releasedAction = releasedAction
        super.init()
        
        setupNodes()
    }
    
    private func setupNodes() {
        self.isUserInteractionEnabled = true
        self.addChild(image)
        self.addChild(icon)
        self.addChild(imagePressed)
        
        image.zPosition = -1
        imagePressed.zPosition = 1
        icon.zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setButtonPressed(true)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setButtonPressed(false)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        setButtonPressed(false)
    }
    
    private func setButtonPressed(_ value: Bool) {
        self.image.isHidden = value
        self.imagePressed.isHidden = !value
        
        if(value) {
            self.pressedAction?()
        } else {
            self.releasedAction?()
        }
    }
    
}
