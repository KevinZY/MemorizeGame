//
//  ContentView.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/12.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var gameViewModel:EmojyMemorizeGame
    
    var body: some View{
        VStack{
            Text("Memorize!").font(.largeTitle)
            Spacer()
            ScrollView(content: {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(gameViewModel.gameModel.cards){card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    }
                }
            })
        }
        .padding()
    }
}

struct CardView: View {
    
    var card: MemorizeGame<String>.Card

    var body: some View{
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack{
            if card.isMatched{
                shape.opacity(0)
            }else if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(card.content).font(.largeTitle)
            }else {
                shape.fill()
            }
        }.foregroundColor(.red)
    }
}



























//生成左侧预览界面用的
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gameViewModel: EmojyMemorizeGame()).preferredColorScheme(.light)
        ContentView(gameViewModel: EmojyMemorizeGame()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
