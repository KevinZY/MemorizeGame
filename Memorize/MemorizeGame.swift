//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/21.
//

import Foundation


struct MemorizeGame<Content> where Content: Hashable{
    
    private var contentPool: [Content]
    private(set) var cards: [Card]
    private var usedContentIndex:Int
    
    private var faceUpCardsIndexes: [Int]{
        var indexes:[Int] = []
        for i in cards.indices {
            if cards[i].isFaceUp {indexes.append(i)}
        }
        return indexes;
    }
    
    private var backgroundColors = [CardColorEnum.BLUE, CardColorEnum.RED, CardColorEnum.YELLOW]
    
    init(contentPool: [Content], forInitCardNumber: Int) {
        self.contentPool = contentPool
        self.cards = []
        self.usedContentIndex = 0
        self.contentPool.shuffle()
        for i in 0..<forInitCardNumber {
            cards.append(Card(id: i*3, content: self.contentPool[i]))
            cards.append(Card(id: i*3 + 1 , content: self.contentPool[i]))
            cards.append(Card(id: i*3 + 2, content: self.contentPool[i]))
            usedContentIndex += 1
        }
    }
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(where: {$0.id == card.id}) , cards[index].canBeFlipped{
            cards[index].isFaceUp.toggle()
            let faceUpCardNumber: Int = faceUpCardsIndexes.count
            //有大于三张卡片被翻开时，做真实匹配和清除结果操作
            if faceUpCardNumber > 3{
                //除去当前选中的第四张卡
                let selectedIndex = faceUpCardsIndexes.filter({$0 != index})
                //如果卡片的内容相同，说明三张牌匹配
                if Set(selectedIndex.map({cards[$0].content})).count == 1 {
                    if usedContentIndex >= contentPool.count {
                        selectedIndex.sorted(by: >).forEach({cards.remove(at: $0)})  //必须倒序删除，否则数组越界
                    }else{
                        selectedIndex.forEach({ i in
                            let removedCard = cards.remove(at: i)
                            cards.insert(Card(id: removedCard.id, content: self.contentPool[usedContentIndex]), at: i)
                        })
                        usedContentIndex += 1
                    }
                }else{
                    //移除翻开的卡片，并将背景清空
                    selectedIndex.forEach({i in
                        cards[i].canBeFlipped = true
                        cards[i].isFaceUp = false
                        cards[i].foregroundColor = .WHITE
                    })
                }
            }
            //刚好三张卡片被翻开的时候，做颜色渲染操作
            else if faceUpCardNumber == 3{
                var colorIndex = 0
                var distinctContentMap: [Content: CardColorEnum] = [:]
                //将内容去重，并为每一种内容指定颜色
                for c in Set(faceUpCardsIndexes.map({cards[$0].content})) {
                    distinctContentMap[c] = CardColorEnum.get(byOrder: colorIndex)
                    colorIndex += 1
                }
                
                //将翻开的卡片进行染色
                for i in faceUpCardsIndexes {
                    cards[i].canBeFlipped = false
                    cards[i].foregroundColor = distinctContentMap[cards[i].content] ?? .WHITE
                }
            }
            print(cards)
        }
    }
        
    struct Card: Identifiable {
        var id: Int
        let content: Content
        var isFaceUp = false
        var canBeFlipped = true
        var foregroundColor:CardColorEnum = .WHITE
    }
}
