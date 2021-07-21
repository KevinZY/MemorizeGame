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
    
    init(numberOfCards: Int = 4) {
        EmojyMemorizeGame.contents.shuffle()
        gameModel = MemorizeGame(contentPool: EmojyMemorizeGame.contents, forInitCardNumber: numberOfCards)
    }
    
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
}
