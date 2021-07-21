//
//  CardColorEnum.swift
//  Memorize
//
//  Created by 张洋 on 2021/7/21.
//

import Foundation

enum CardColorEnum {
    case RED
    case YELLOW
    case BLUE
    case WHITE
    
    static func get(byOrder order: Int) -> CardColorEnum {
        switch order {
        case 0: return CardColorEnum.RED
        case 1: return CardColorEnum.YELLOW
        case 2: return CardColorEnum.BLUE
        default: return CardColorEnum.WHITE
        }
    }
}
