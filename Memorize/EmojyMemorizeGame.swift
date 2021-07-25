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
        gameModel = MemorizeGame(contentPool: EmojyMemorizeGame.contents, forInitCardNumber: numberOfCards)
    }
    
    func deal3MoreCards() {
        gameModel.deal3MoreCards()
    }
    
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
    
    func newGame(numberOfCards: Int) {
        gameModel = MemorizeGame(contentPool: EmojyMemorizeGame.contents, forInitCardNumber: numberOfCards)
    }
}
