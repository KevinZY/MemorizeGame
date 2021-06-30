//
//  EmojyMemorizeGameViewModel.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/27.
//

import Foundation

class EmojyMemorizeGame: ObservableObject {
    static let emojys = ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚔","🚍","🚘","🚖","🚡","🚠","🚟","🚃","🚋"]
    
    @Published private(set) var gameModel: MemorizeGame<String>
    
    init() {
        gameModel = MemorizeGame(numberOfCards: 4) { index in
            EmojyMemorizeGame.emojys[index]
        }
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        gameModel.choose(card)
    }
    
}
