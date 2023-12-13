//
//  RoomSelectionScene.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import Foundation
import SpriteKit

public class RoomSelectionScene: SKScene {
    
    private var roomView: RoomSelectionView?
    
    public init(size: CGSize, view: RoomSelectionView) {
        self.roomView = view
        super.init(size: size)
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        setupScene()
        setupCamera()
    }
    
    private func setupCamera() {
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        cameraNode.setScale(1.5)
    }
    
    private func setupScene() {
        for i in 1...12 {
            let button = RoomButtonNode(imageNamed: "roomButton", releasedAction:  {
                self.roomView?.selectedRoom(index: i)
            })
            
            button.isLocked = i != 1
            self.addChild(button)
            
            let size = button.image.size

            let row = (i - 1) % 4  // (index - 1) / numCols
            let col = (i - 1) / 4 // (index - 1) % numCols
            
            button.position = .init(
                x: -self.size.width/2 + size.width/2,
                y: -self.size.height/2 + size.height + 50)
            
            button.position.x += CGFloat(row) * (size.width + 20)
            button.position.y += CGFloat(col) * (size.height + 90)
        }
    }
}
