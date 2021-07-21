//
//  EmojyMemorizeGame.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/21.
//

import Foundation

class EmojyMemorizeGame: ObservableObject {
    typealias Card = MemorizeGame<String>.Card
    
    @Published var gameModel: MemorizeGame<String>
    
    static var contents = ["🐶", "🐷", "🐔", "🐹", "🐻", "🐮", "🦁", "🐸", "🙊", "🐯", "🦉"]
    
    init(pairNumberOfCards: Int = 4) {
        EmojyMemorizeGame.contents.shuffle()
        gameModel = MemorizeGame(
            pairNumberOfCards: min(pairNumberOfCards, EmojyMemorizeGame.contents.count),
            content: { EmojyMemorizeGame.contents[$0] }
        )
    }
    
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
}
