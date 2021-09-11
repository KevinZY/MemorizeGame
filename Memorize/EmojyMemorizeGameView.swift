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
                if card.isMatched && !card.isFaceUp {
                    //注意放的位置，如果放到cardView里面，则控制的还是cardView的效果
                    Color.clear
                }else{
                    CardView(card)
                    .padding(4)
                    .transition(AnyTransition.scale)
                    .onTapGesture {
                        withAnimation(.easeOut){
                            game.choose(card)
                        }
                    }
                }
            }).foregroundColor(.red)
            HStack{
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.75)){
                        game.newGame()
                    }
                }, label: {
                    Image(systemName: "macwindow.badge.plus")
                    Text("NewGame")
                })
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.75)){
                        game.shuffle()
                    }
                }, label: {
                    Image(systemName: "shuffle.circle")
                    Text("Shuffle")
                })
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
            ZStack{
                //TODO: 重点研究SwiftUI的坐标系
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120 - 90)).padding(5).opacity(0.6)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(Animation.linear(duration: 1).repeat(while: card.isFaceUp))
                    .font(Font.system(size: DrawingConsts.fontSize))
                    .scaleEffect(scale(geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    //TODO: 为什么使用scale可以避免位置移动的动画？
    //分析：1.scaleeffect中有个默认参数ancher，默认锚点为center，所以每次都会以中心来进行变化
    //由于animation只修饰其之前的view，所以scaleEffect看起来是瞬间完成的
    fileprivate func scale(_ size: CGSize) -> CGFloat{
        return (min(size.width, size.height)/DrawingConsts.fontSize) * DrawingConsts.fontScale
    }
    
    private struct DrawingConsts{
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}

extension View{
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

extension Animation{
    func `repeat`(while exp: Bool, autoreverse: Bool = false) -> Animation {
        if exp {
            return self.repeatForever(autoreverses: autoreverse)
        }else{
            return self
        }
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
