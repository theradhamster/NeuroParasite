//
//  GameScene.swift
//  NeuroParasite
//
//  Created by Dorothy Luetz on 2/1/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var stone: SKSpriteNode!
    override func didMove(to view: SKView) {
        stone = SKSpriteNode(imageNamed: "stenobrim")
        stone.position = CGPoint(x: 100, y: 384)
        stone.physicsBody = SKPhysicsBody(texture: stone.texture!, size: stone.size)
        stone.physicsBody?.contactTestBitMask = 1
        addChild(stone)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        stone.position = location
    }
}
