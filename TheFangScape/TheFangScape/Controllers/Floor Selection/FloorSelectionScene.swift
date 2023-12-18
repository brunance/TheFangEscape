//
//  FloorSelectionScene.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import Foundation
import SpriteKit

public class FloorSelectionScene: SKScene {
    
    private var floorView: FloorSelectionView?
    
    public init(size: CGSize, view: FloorSelectionView) {
        self.floorView = view
        super.init(size: size)
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        setupScene()
    }
    
    private func setupScene() {
        
        let buttonInfo: [(color: UIColor, size: CGSize, floorIndex: Int, position: CGPoint)] = [
            (.red, CGSize(width: 189, height: 159), 1, .init(x: -100, y: -250)),
            (.yellow, CGSize(width: 364, height: 150), 2, .init(x: 0, y: -50))
        ]

        for info in buttonInfo {
            let floorButton = FloorButtonNode(image: SKSpriteNode(color: info.color, size: info.size), releasedAction: {
                print("Go To Floor \(info.floorIndex)")
                self.floorView?.selectedFloor(index: info.floorIndex)
            })
            
            floorButton.isLocked = info.floorIndex > LevelManager.shared.getFloor()
            self.addChild(floorButton)
            
            floorButton.position = info.position
        }
    }
    
}
