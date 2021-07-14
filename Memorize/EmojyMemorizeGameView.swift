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
            AspectVGrid(items: game.gameModel.cards, aspectRatio: 2/3, content: {card in
                CardView(card).onTapGesture {
                    game.choose(card)
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
                    //TODO: 重点研究SwiftUI的坐标系
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120 - 90)).padding(5).opacity(0.6)
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
        let game: EmojyMemorizeGame = EmojyMemorizeGame()
        game.choose(game.gameModel.cards.first!)
        return EmojyMemorizeGameView(game: game).preferredColorScheme(.light)
    }
}
