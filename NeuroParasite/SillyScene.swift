//
//  SillyScene.swift
//  NeuroParasite
//
//  Created by Dorothy Luetz on 2/1/24.
//

import SpriteKit
import GameplayKit

enum GameState {
    case showingStart, playing, ended
}

class SillyScene: SKScene, SKPhysicsContactDelegate {
    
    var logo: SKSpriteNode!
    var gameState = GameState.showingStart
    var wagon: SKSpriteNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var scoreLabel: SKLabelNode!
    var stone: SKSpriteNode!
    var weedStone: SKSpriteNode!
    var wagonCollision: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "nordstrom.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -10
        addChild(background)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        scoreLabel = SKLabelNode(fontNamed: "SF-Pro")
        scoreLabel.position = CGPoint(x: 200, y: 600)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        score = 0
        let wagonTexture = SKTexture(imageNamed: "wagon2")
        wagon = SKSpriteNode(texture: wagonTexture)
        wagon.position = CGPoint(x: 200, y: 70)
        wagon.zPosition = 1
        //wagon.physicsBody = SKPhysicsBody(texture: wagonTexture, size: wagonTexture.size())
        wagon.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 70))
        wagon.physicsBody?.contactTestBitMask = 1
        wagon.physicsBody?.isDynamic = false
        wagon.name = "wagon"
        wagonCollision = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 150, height: 70))
        wagonCollision.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 70))
        wagonCollision.physicsBody?.contactTestBitMask = 1
        wagonCollision.physicsBody?.isDynamic = false
        wagonCollision.position = wagon.position
        wagonCollision.zPosition = 2
        wagonCollision.name = "wagonCollision"
        addChild(wagon)
        //addChild(wagonCollision)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -4.0)
        createLogos()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .showingStart:
            gameState = .playing
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let remove = SKAction.removeFromParent()
            let wait = SKAction.wait(forDuration: 0.5)
            let activateStones = SKAction.run { [unowned self] in
//                self.wagon.physicsBody?.isDynamic = false
//                self.wagonCollision.physicsBody?.isDynamic = false
                self.startStones()
                self.startWeedStones()
            }
            let sequence = SKAction.sequence([fadeOut, wait, activateStones, remove])
            logo.run(sequence)
        case .playing:
            print("placeholder")
        case .ended:
            if let scene = SillyScene(fileNamed: "SillyScene") {
                scene.scaleMode = .aspectFill
                let transition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 1)
                view?.presentScene(scene, transition: transition)
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        if location.x < 100 {
            location.x = 100
        } else if location.x > 668 {
            location.x = 668
        }
        location.y = 70
        wagon.position = location
        wagonCollision.position = location
    }
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.y < 40 {
                node.removeFromParent()
            }
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        guard contact.bodyA.node != nil && contact.bodyB.node != nil else {
            return
        }
        if contact.bodyA.node == stone || contact.bodyB.node == stone {
            score += 1
            stone.removeFromParent()
        }
        if contact.bodyA.node == weedStone || contact.bodyB.node == weedStone {
            score += 3
            weedStone.removeFromParent()
        }
    }
    func createStones() {
        let stoneTexture = SKTexture(imageNamed: "stenobrim")
        stone = SKSpriteNode(texture: stoneTexture)
        stone.physicsBody = SKPhysicsBody(texture: stoneTexture, size: stoneTexture.size())
        stone.name = "stone"
        let xPostition = CGFloat.random(in: 40...350)
        let yPosition = CGFloat.random(in: 400...580)
        stone.position = CGPoint(x: xPostition, y: yPosition + stone.size.height)
        stone.zPosition = 2
        addChild(stone)
        stone.physicsBody?.velocity = CGVector(dx: 0, dy: -250)
        stone.physicsBody?.angularVelocity = 2
        stone.physicsBody?.linearDamping = 0
        stone.physicsBody?.angularDamping = 0
    }
    func startStones() {
        let create = SKAction.run { [unowned self] in
                self.createStones()
            }

        let wait = SKAction.wait(forDuration: 1.5)
            let sequence = SKAction.sequence([create, wait])
            let repeatForever = SKAction.repeatForever(sequence)

            run(repeatForever)
    }
    func createWeedStones() {
        let stoneTexture = SKTexture(imageNamed: "stenoweed")
        weedStone = SKSpriteNode(texture: stoneTexture)
        weedStone.physicsBody = SKPhysicsBody(texture: stoneTexture, size: stoneTexture.size())
        weedStone.name = "weedstone"
        let xPostition = CGFloat.random(in: 40...350)
        let yPosition = CGFloat.random(in: 400...580)
        weedStone.position = CGPoint(x: xPostition, y: yPosition + weedStone.size.height)
        weedStone.zPosition = 2
        addChild(weedStone)
        weedStone.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        weedStone.physicsBody?.angularVelocity = 1.5
        weedStone.physicsBody?.linearDamping = 0
        weedStone.physicsBody?.angularDamping = 0
    }
    func startWeedStones() {
        let create = SKAction.run { [unowned self] in
                self.createWeedStones()
            }

        let wait = SKAction.wait(forDuration: 4.5)
            let sequence = SKAction.sequence([create, wait])
            let repeatForever = SKAction.repeatForever(sequence)

            run(repeatForever)
    }
    func createLogos() {
        logo = SKSpriteNode(imageNamed: "stenobrim")
        logo.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(logo)
    }
}
