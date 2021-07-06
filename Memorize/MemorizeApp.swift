//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/12.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let memorizeGame = EmojyMemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            EmojyMemorizeGameView(game:memorizeGame)
        }
    }
}
