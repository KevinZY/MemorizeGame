//
//  CardView.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/21.
//

import SwiftUI


struct CardView: View {
    var card: MemorizeGame<String>.Card
    var fontScale: CGFloat = 0.7

    var body: some View {
        GeometryReader{geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 12)
                if card.isMatched{
                    shape.opacity(0)
                }else if card.isFaceUp{
                    shape.fill().foregroundColor(calColor(by: card.foregroundColor).opacity(0.5))
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(
                            Font.system(size: min(geometry.size.height, geometry.size.width) * fontScale)
                        )
                }else{
                    shape.fill()
                }
            }.foregroundColor(.blue)
        }
    }
    
    func calColor(by colorEnum: CardColorEnum) -> Color {
        switch colorEnum {
        case .RED:
            return .red
        case .BLUE:
            return .blue
        case .YELLOW:
            return .yellow
        default:
            return .white
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let game: EmojyMemorizeGame = EmojyMemorizeGame()
        var card: MemorizeGame<String>.Card = game.gameModel.cards.first!
        card.isFaceUp = true
        return CardView(card: card)
    }
}

