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
        
        // MARK: Instance
        let floor1 = ButtonNode(image: .init(color: .red, size: .init(width: 189, height: 159)), releasedAction:  {
            print("Go To Floor 1")
            self.floorView?.selectedFloor(index: 1)
        })
        self.addChild(floor1)
        
        let floor2 = ButtonNode(image: .init(color: .yellow, size: .init(width: 364, height: 150)), releasedAction:  {
            print("Go To Floor 2")
            self.floorView?.selectedFloor(index: 2)
        })
        self.addChild(floor2)
        
        // MARK: Adjust Positions
        floor1.position = .init(x: -100, y: -250)
        floor2.position = .init(x: 0, y: -50)
    }
    
}
