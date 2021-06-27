//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/27.
//

import Foundation

struct MemorizeGame<CardContent>{
    var cards: Array<Card>
    
    struct Card {
        var content: CardContent
        var isFaceUp: Bool
    }
}
