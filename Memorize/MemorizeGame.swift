//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/27.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private var lastIndex: Int?
    private(set) var point: Int = 0
    private var flapedCardIndex: Set<Int> = []
    
    init(numberOfCards: Int, createContent: (_ index: Int) -> CardContent) {
        cards = Array<Card>()
        for i in 0..<numberOfCards {
            cards.append(Card(content: createContent(i), id: i))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let i = cards.firstIndex(where: { $0.id == card.id}), !cards[i].isMatched, !cards[i].isFaceUp{
            if let li = lastIndex{
                if li != i && cards[li].content == cards[i].content {
                    cards[i].isMatched = true
                    cards[li].isMatched = true
                    point += 2
                }else{
                    if flapedCardIndex.contains(li) {
                        point -= 1
                    }
                    if flapedCardIndex.contains(i) {
                        point -= 1
                    }
                    flapedCardIndex.insert(i)
                    flapedCardIndex.insert(li)
                }
                lastIndex = nil
            }else{
                for j in cards.indices{
                    cards[j].isFaceUp = false
                }
                lastIndex = i
            }
            cards[i].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        
        var id: Int
    }
    
}
