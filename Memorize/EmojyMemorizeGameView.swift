//
//  EmojyMemorizeGameView.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/21.
//

import SwiftUI

struct EmojyMemorizeGameView: View {
    
    @ObservedObject var gameView = EmojyMemorizeGame(numberOfCards: 4)
    
    var body: some View {
        VStack{
            AdaptiveAspectVGrid(items: gameView.gameModel.cards, aspectRatio: 2/2.5, content: {card in
                CardView(card: card).onTapGesture {gameView.choose(card)}
            })
            Spacer()
            HStack{
                dealCardsButton.disabled(!gameView.gameModel.canDealMoreCards)
                Spacer()
                newGameButton
            }
            
        }.padding()
    }
    
    var dealCardsButton: some View{
        Button(action: {
            gameView.deal3MoreCards()
        }, label: {
            Image(systemName: "plus.square.on.square")
            Text("Deal 3 More Cards")
        })
    }
    var newGameButton: some View {
        Button(action: {
            gameView.newGame(numberOfCards: 4)
        }, label: {
            Image(systemName: "arrow.clockwise")
            Text("New Game")
        })
    }
    
}

struct EmojyMemorizeGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game: EmojyMemorizeGameView = EmojyMemorizeGameView()
        game.gameView.choose(game.gameView.gameModel.cards.first!)
        return game
    }
}
