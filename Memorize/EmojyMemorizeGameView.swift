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
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(gameView.gameModel.cards, content: { card in
                    CardView(card: card)
                        .aspectRatio(2/2.5 , contentMode: .fit)
                        .onTapGesture {gameView.choose(card)}
                })
            }.padding()
        }
    }
}

struct EmojyMemorizeGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game: EmojyMemorizeGameView = EmojyMemorizeGameView()
        game.gameView.choose(game.gameView.gameModel.cards.first!)
        return game
    }
}
