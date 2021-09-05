//
//  Cardify.swift
//  Memorize
//
//  Created by 张洋 on 2021/8/9.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double{
        get{ rotation }
        set{ rotation = newValue }
    }
    
    
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConsts.cornerRadius)
        ZStack{
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConsts.borderWidth)
            }else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }.rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
    private struct DrawingConsts{
        static let cornerRadius: CGFloat = 20
        static let opacity:Double = 0
        static let borderWidth: CGFloat = 3
    }
}
