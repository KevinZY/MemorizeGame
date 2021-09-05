//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/27.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private var lastIndex: Int?{
        get{ cards.indices.filter {cards[$0].isFaceUp == true}.oneAndOnly }
        set{ cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)} }
    }
    private(set) var point: Int
    private var flapedCardIndex: Set<Int>
    
    init(numberOfCards: Int, createContent: (_ index: Int) -> CardContent) {
        cards = []
        point = 0
        flapedCardIndex = []
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
                cards[i].isFaceUp = true
            }else{
                lastIndex = i
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isFaceUp = false
        var isMatched = false
        
        var id: Int
    }
}

extension Array{
    var oneAndOnly: Element?{
        if self.count == 1 {
            return self.first
        }else{
            return nil
        }
    }
}
