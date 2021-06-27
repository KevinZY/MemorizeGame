//
//  ContentView.swift
//  Memorize
//
//  Created by 张洋 on 2021/6/12.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojys: [String] = CardConent.transportation
    
    @State var cardCount = CardConent.transportation.count/2
    
    //something behaves like a view
    var body: some View{
        VStack{
            Text("Memorize!").font(.largeTitle)
            HStack{
                addButton
                Spacer()
                removeButton
            }.font(.title)
            Spacer()
            ScrollView(content: {
                /**
                 LazyVGrid和LazyHGrid的区别？
                 GridItem自适应的原理？
                 */
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojys[0..<cardCount], id: \.self){emojy in
                        /**
                         使用aspectRatio来固定长宽比
                         contenModel几种模式的区别？
                         */
                        CardView(isFaceUp: true, text: emojy).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            })
            Spacer()
            HStack{
                themeButtonCar
                Spacer()
                themeButtonAnimal
                Spacer()
                themeButtonFlag
            }.font(.largeTitle)
        }
        .padding()
    }
    
    
    var themeButtonCar: some View{
        Button(action: {
            emojys = CardConent.transportation
            emojys.shuffle()
            cardCount = Int.random(in: 4..<emojys.count)
        }, label: {
            VStack{
                Image(systemName: "car")
                Text("Vehicles").font(.subheadline)
            }
        })
    }
    
    var themeButtonAnimal: some View{
        Button(action: {
            emojys = CardConent.animal
            emojys.shuffle()
            cardCount = Int.random(in: 4..<emojys.count)
        }, label: {
            VStack{
                Image(systemName: "hare")
                Text("Animals").font(.subheadline)
            }
        })
    }
    
    var themeButtonFlag: some View{
        Button(action: {
            emojys = CardConent.flag
            emojys.shuffle()
            cardCount = Int.random(in: 4..<emojys.count)
        }, label: {
            VStack{
                Image(systemName: "flag")
                Text("Flags").font(.subheadline)
            }
            
        })
    }
    
    
    /**
     注意Button类型为 some View，否则报错，无法使用cardCount变量
     为什么？
     */
    var addButton: some View {
        Button(action: {
            if cardCount < emojys.count{
                cardCount += 1;
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
    
    var removeButton: some View{
        Button(action: {
            if cardCount > 0{
                cardCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
}

struct CardView: View {
    @State var isFaceUp = true
    var text:String
    
    var body: some View{
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack{
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                /**
                 使用strokeBorder为向内画边框，不会被外部遮挡
                 */
                shape.strokeBorder(lineWidth: 3.0)
                Text(text).font(.largeTitle)
            }else {
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }.foregroundColor(.red)
    }
}



























//生成左侧预览界面用的
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
        ContentView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
