//
//  GameView.swift
//  NeuroParasite
//
//  Created by Dorothy Luetz on 2/1/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 740)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 500, height: 900)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    GameView()
}
