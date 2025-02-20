//
//  Parser.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 20.02.2025.
//

import Foundation

func ParseCondition(condition: String) -> ([Condition], [LogicOp])? {
    var res: [Condition] = []
    var lps: [LogicOp] = []
    let tokens = condition.components(separatedBy: " ")
    var ptr: Int = 0
    var sign: Sign
    var prop: Property
    var n: Int = 0
    
    if ((tokens.count + 1) % 4 != 0) {
        return nil;
    } else {
        n = (tokens.count + 1) / 4
    }
        
    for _ in 0...n {
        ptr += 4
        switch tokens[ptr] {
        case "Title":
            prop = .Title("")
        case "Author":
            prop = .Author("")
        case "PubYear":
            prop = .PubYear(Date.init())
        case "Genre":
            prop = .Genre(Genre.fiction)
        default:
            return nil
        }
        
        switch tokens[ptr + 1] {
        case "==":
            sign = .eq
        case "<":
            sign = .lt
        case ">":
            sign = .gt
        default:
            return nil
        }
        
        switch prop {
        case .Title(_):
            prop = .Title(tokens[ptr + 2])
        case .Author(_):
            prop = .Author(tokens[ptr + 2])
        case .PubYear(_):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: tokens[ptr + 2]) {
                prop = .PubYear(date)
            } else {
                return nil;
            }
        case .Genre(_):
            let a: Genre  = Genre.init(name: tokens[ptr + 2])
            if (a != .none) {
                prop = .Genre(a)
            } else {
                return nil
            }
        }
        
        res.append(Condition(sign: sign, prop: prop))
        
        if (n == 1) {
            return (res, lps)
        } else {
            switch tokens[ptr + 3] {
            case "&&":
                lps.append(LogicOp.and)
            case "||":
                lps.append(LogicOp.or)
            default:
                return nil;
            }
        }
    }
    
    return (res, lps)
}
