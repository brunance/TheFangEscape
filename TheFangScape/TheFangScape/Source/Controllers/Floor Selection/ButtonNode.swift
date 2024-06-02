//
//  ButtonNode.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import Foundation
import SpriteKit

public class ButtonNode: SKNode {
    
    var image: SKSpriteNode
    var imagePressed: SKSpriteNode?
    var pressedAction: (() -> Void)?
    var releasedAction: (() -> Void)?
    
    init(image: SKSpriteNode, imagePressed: SKSpriteNode? = nil, pressedAction: ( () -> Void)? = nil, releasedAction: ( () -> Void)? = nil) {
        self.image = image
        self.imagePressed = imagePressed
        self.pressedAction = pressedAction
        self.releasedAction = releasedAction
        super.init()
        
        setupNodes()
    }
    
    init(imageNamed: String,
         imagePressedNamed: String? = nil,
         pressedAction: ( () -> Void)? = nil,
         releasedAction: ( () -> Void)? = nil) {
        self.image = SKSpriteNode(imageNamed: imageNamed)
        self.pressedAction = pressedAction
        self.releasedAction = releasedAction
        super.init()
        
        setupNodes()
    }
    
    private func setupNodes() {
        self.isUserInteractionEnabled = true
        self.addChild(image)
        if imagePressed == nil {
            imagePressed = image.copy() as? SKSpriteNode
        }
        self.addChild(imagePressed!)
        
        image.zPosition = -1
        imagePressed?.zPosition = 1
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
        self.imagePressed?.isHidden = !value
        
        if(value) {
            self.pressedAction?()
        } else {
            self.releasedAction?()
        }
    }
    
}
