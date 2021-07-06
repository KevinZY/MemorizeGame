//
//  EmojyMemorizeGame.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/27.
//

import Foundation

class EmojyMemorizeGame: ObservableObject {
    
    typealias Card = MemorizeGame<String>.Card
    
    @Published private(set) var gameModel: MemorizeGame<String>
    
    @Published private(set) var theme: MemorizeGameTheme
    
    private var themes: [MemorizeGameTheme] = [VehicleTheme(), AnimalTheme()]
    
    init() {
        let element = themes.randomElement()!
        theme = element
        let cardNumber = 8
        let content = element.getContent(number: cardNumber)
        gameModel = MemorizeGame(numberOfCards: content.count) { index in
            content[index]
        }
    }
    
    func newGame() {
        theme = themes.randomElement()!
        let cardNumber = 8
        let content = theme.getContent(number: cardNumber)
        gameModel = MemorizeGame(numberOfCards: content.count) { index in
            content[index]
        }
    }
    
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
    
}
