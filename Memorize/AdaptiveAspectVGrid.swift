//
//  AdaptiveAspectVGrid.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/25.
//

import SwiftUI

struct AdaptiveAspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable{
    
    var items: [Item]
    var content: (Item) -> ItemView
    var aspectRatio: CGFloat
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(items, content: { card in
                    content(card).aspectRatio(aspectRatio , contentMode: .fit)
                })
            }
        }
    }
    
    func calWidth(size: CGSize) -> CGFloat {
        65
    }
    
}
