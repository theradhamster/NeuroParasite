//
//  SillyView.swift
//  NeuroParasite
//
//  Created by Dorothy Luetz on 2/1/24.
//

import SwiftUI
import SpriteKit

struct SillyView: View {
    var scene: SKScene {
        let scene = SillyScene()
        scene.size = CGSize(width: 400, height: 690)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 500, height: 852)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SillyView()
}
