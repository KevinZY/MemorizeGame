//
//  ContentView.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/12.
//

import SwiftUI

struct EmojyMemorizeGameView: View {
    
    
    @ObservedObject var game:EmojyMemorizeGame
    
    @Namespace private var dealing
    
    @State private var dealtCardIndex:Set<Int> = []
    
    var body: some View{
        VStack{
            Text("\(game.theme.name)").font(.largeTitle)
            Text("Point: \(game.gameModel.point)").font(.title2)
            Spacer()
            gameBody
            deckBody
            HStack{
                newGameButton
                Spacer()
                shuffleButton
            }
        }
        .padding()
    }
    
    func zIndex(_ card: MemorizeGame<String>.Card) -> Double {
        -Double(game.gameModel.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View{
        AspectVGrid(items: game.gameModel.cards, aspectRatio: DrawingConsts.aspectRatio , content: {card in
            if isUndealt(card: card) || (card.isMatched && !card.isFaceUp) {
                //注意放的位置，如果放到cardView里面，则控制的还是cardView的效果
                Color.clear
            }else{
                CardView(card)
                .matchedGeometryEffect(id: card.id, in: dealing)
                .zIndex(zIndex(card))
//                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                .onTapGesture {
                    withAnimation(.easeInOut){
                        game.choose(card)
                    }
                }
            }
        }).foregroundColor(.red)
    }
    
    var deckBody: some View{
        ZStack{
            ForEach(game.gameModel.cards.filter(isUndealt)){
                CardView($0)
                    .matchedGeometryEffect(id: $0.id, in: dealing)
                    .zIndex(zIndex($0))
            }
        }
        .frame(width: DrawingConsts.undealtWidth, height: DrawingConsts.undealtHeight)
        .foregroundColor(.red)
        .onTapGesture {
            for card in game.gameModel.cards{
                withAnimation(dealAnimation(card)) {
                    deal(card: card)
                }
            }
        }
    }
    
    
    func deal(card: MemorizeGame<String>.Card) {
        dealtCardIndex.insert(card.id)
    }
    
    func isUndealt(card: MemorizeGame<String>.Card) -> Bool {
        !dealtCardIndex.contains(card.id)
    }
    
    var newGameButton: some View{
        Button(action: {
            withAnimation(.easeInOut){
                dealtCardIndex.removeAll()
                game.newGame()
            }
        }, label: {
            Image(systemName: "macwindow.badge.plus")
            Text("NewGame")
        })
    }
    
    var shuffleButton: some View{
        Button(action: {
            withAnimation(.easeInOut(duration: 0.75)){
                game.shuffle()
            }
        }, label: {
            Image(systemName: "shuffle.circle")
            Text("Shuffle")
        })
    }
    
    func dealAnimation(_ card: MemorizeGame<String>.Card) -> Animation {
        var delay = 0.0
        if let index = game.gameModel.cards.firstIndex(where: { $0.id == card.id}){
            delay = Double(index) * 2 / Double(game.gameModel.cards.count)
        }
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
}

struct CardView: View {
    
    typealias Card = MemorizeGame<String>.Card
    
    @State var animatedCountTimeRemaining:Double = 0
    
    private var card: Card
    
    init(_ givenCard: Card) {
        card = givenCard
    }
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                //TODO: 重点研究SwiftUI的坐标系
                Group{
                    if card.isConsumingCountTime{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1 - animatedCountTimeRemaining) * 360 - 90))
                            .onAppear{
                                animatedCountTimeRemaining = card.percentageRemaining
                                withAnimation(.linear(duration: card.timeRemaing)) {
                                    animatedCountTimeRemaining = 0
                                }
                            }
                    }else{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1 - card.percentageRemaining) * 360 - 90))
                    }
                }.padding(5).opacity(0.6)
                
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
    
    
}

private struct DrawingConsts{
    static let fontScale: CGFloat = 0.7
    static let fontSize: CGFloat = 32
    static let aspectRatio: CGFloat = 2 / 3
    static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    static let undealtHeight: CGFloat = 90
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
