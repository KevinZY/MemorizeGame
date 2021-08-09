//
//  MemorizeGameTheme.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/3.
//

import Foundation

protocol MemorizeGameTheme {
    var name:String {get}
    var emojys:[String] {get}
    func getContent(number: Int) -> [String]
}

struct VehicleTheme: MemorizeGameTheme{
    let name: String = "Vehicles"
    let emojys = ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚔","🚍","🚘","🚖","🚡","🚠","🚟","🚃","🚋"]
    
    func getContent(number: Int) -> [String] {
        let realNumber = number > emojys.count ? emojys.count : number
        var r = emojys
        r.shuffle()
        r = Array(r[0..<realNumber])
        r += r
//        r.shuffle()
        return Array(r)
    }
}


struct AnimalTheme: MemorizeGameTheme{
    let name: String = "Animals"
    let emojys = ["🐶", "🐷", "🦁", "🐔"]
    
    func getContent(number: Int) -> [String] {
        let realNumber = number > emojys.count ? emojys.count : number
        var r = emojys
        r.shuffle()
        r = Array(r[0..<realNumber])
        r += r
//        r.shuffle()
        return Array(r)
    }
}
