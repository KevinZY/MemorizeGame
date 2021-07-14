//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/14.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item:Identifiable{
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var width: CGFloat = 65
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]) {
                    ForEach(items){item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer()
            }
        }
    }
}
