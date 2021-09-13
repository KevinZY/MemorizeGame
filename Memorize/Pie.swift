//
//  PieShape.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/14.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    //⚠️Shape天生支持Animatable，但是需要实现animatableData
    var animatableData: AnimatablePair<Double, Double> {
        get{
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startPoint = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        path.move(to: center)
        path.addLine(to: startPoint)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        path.addLine(to: center)
        return path
    }
}


