//
//  Cardify.swift
//  Memorize
//
//  Created by 张洋 on 2021/8/9.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    var visible: Bool
    
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConsts.cornerRadius)
        ZStack{
            if !visible{
                shape.opacity(DrawingConsts.opacity)
            }else if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConsts.borderWidth)
            }else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }.foregroundColor(.red)
    }
    
    private struct DrawingConsts{
        static let cornerRadius: CGFloat = 20
        static let opacity:Double = 0
        static let borderWidth: CGFloat = 3
    }
}
