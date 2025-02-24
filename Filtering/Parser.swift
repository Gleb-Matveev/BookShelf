//
//  Parser.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 20.02.2025.
//

import Foundation

enum ParsingError: Error {
    case noSuchValue
    case wrongNumberOfArgs
    case invalidInput
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
        return Result.failure(ParsingError.wrongNumberOfArgs);
    } else {
        n = (tokens.count + 1) / 4
    }
        
    for k in 0...n {
        switch tokens[ptr] {
        case "Title":
            prop = .title("")
        case "Author":
            prop = .author("")
        case "PubYear":
            prop = .pubYear(Date.init())
        case "Genre":
            prop = .genre(Genre.fiction)
        default:
            return Result.failure(ParsingError.invalidInput)
        }
        
        switch tokens[ptr + 1] {
        case "=":
            sign = .eq
        case "<":
            sign = .lt
        case ">":
            sign = .gt
        default:
            return Result.failure(ParsingError.invalidInput)
        }
        
        switch prop {
        case .title(_):
            prop = .title(tokens[ptr + 2])
        case .author(_):
            prop = .author(tokens[ptr + 2])
        case .pubYear(_):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: tokens[ptr + 2]) {
                prop = .pubYear(date)
            } else {
                return Result.failure(ParsingError.invalidInput)
            }
        case .genre(_):
            let a: Genre  = Genre.init(name: tokens[ptr + 2])
            if (a != .none) {
                prop = .genre(a)
            } else {
                return Result.failure(ParsingError.invalidInput)
            }
        }
        
        if let cnd = Condition(_sign: sign, _prop: prop) {
            cnds.append(cnd)
        } else {
            return Result.failure(ParsingError.invalidInput)
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
                return Result.failure(ParsingError.invalidInput)
            }
        }
        
        ptr += 4
    }
    
    return Result.success((cnds, lps))
}
