//
//  ContentView.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/12.
//

import SwiftUI

struct EmojyMemorizeGameView: View {
    
    
    @ObservedObject var game:EmojyMemorizeGame
    
    var body: some View{
        VStack{
            Text("\(game.theme.name)").font(.largeTitle)
            Text("Point: \(game.gameModel.point)").font(.title2)
            Spacer()
            ScrollView(content: {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.gameModel.cards){card in
                        CardView(card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    } 
                }
            })
            HStack{
                Button(action: {
                    game.newGame()
                }, label: {
                    Image(systemName: "macwindow.badge.plus")
                    Text("NewGame")
                })
                Spacer()
            }
        }
        .padding()
    }
}

struct CardView: View {
    
    typealias Card = MemorizeGame<String>.Card
    
    private var card: Card
    
    init(_ givenCard: Card) {
        card = givenCard
    }

    
    
    var body: some View{
        GeometryReader{ geometry in
            let shape = RoundedRectangle(cornerRadius: DrawingConsts.cornerRadius)
            ZStack{
                if card.isMatched{
                    shape.opacity(DrawingConsts.opacity)
                }else if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConsts.borderWidth)
                    Text(card.content).font(calFont(geometry))
                }else {
                    shape.fill()
                }
            }.foregroundColor(.red)
        }
    }
    
    fileprivate func calFont(_ geometry: GeometryProxy) -> Font {
        return Font.system(size: min(geometry.size.width, geometry.size.height) * DrawingConsts.fontScale)
    }
    
    private struct DrawingConsts{
        static let cornerRadius: CGFloat = 20
        static let opacity:Double = 0
        static let borderWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}



























//生成左侧预览界面用的
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojyMemorizeGameView(game: EmojyMemorizeGame()).preferredColorScheme(.light)
        EmojyMemorizeGameView(game: EmojyMemorizeGame()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
