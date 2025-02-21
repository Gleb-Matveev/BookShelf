//
//  Parser.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 20.02.2025.
//

import Foundation

enum ParsingError: Error {
    case NoSuchValue
    case WrongNumberOfArgs
    case InvalidInput
}

func ParseCondition(condition: String) -> Result<([Condition], [LogicOp]), ParsingError> {
    var cnds: [Condition] = []
    var lps: [LogicOp] = []
    var sign: Sign
    var prop: Property
    var ptr: Int = 0
    var n: Int = 0
    
    let tokens = condition.components(separatedBy: " ")
    
    if ((tokens.count + 1) % 4 != 0) {
        return Result.failure(ParsingError.WrongNumberOfArgs);
    } else {
        n = (tokens.count + 1) / 4
    }
        
    for k in 0...n {
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
            return Result.failure(ParsingError.InvalidInput)
        }
        
        switch tokens[ptr + 1] {
        case "=":
            sign = .eq
        case "<":
            sign = .lt
        case ">":
            sign = .gt
        default:
            return Result.failure(ParsingError.InvalidInput)
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
                return Result.failure(ParsingError.InvalidInput)
            }
        case .Genre(_):
            let a: Genre  = Genre.init(name: tokens[ptr + 2])
            if (a != .none) {
                prop = .Genre(a)
            } else {
                return Result.failure(ParsingError.InvalidInput)
            }
        }
        
        if let cnd = Condition(_sign: sign, _prop: prop) {
            cnds.append(cnd)
        } else {
            return Result.failure(ParsingError.InvalidInput)
        }
        
        if (n == 1 || k == n - 1) {
            return Result.success((cnds, lps))
        } else {
            switch tokens[ptr + 3] {
            case "&&":
                lps.append(LogicOp.and)
            case "||":
                lps.append(LogicOp.or)
            default:
                return Result.failure(ParsingError.InvalidInput)
            }
        }
        
        ptr += 4
    }
    
    return Result.success((cnds, lps))
}
