//
//  ClosureCreator.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 20.02.2025.
//

import Foundation

enum LogicOp {
    case and
    case or
}

func Append(func1: @escaping (BookProtocol) -> Bool,
            func2: @escaping (BookProtocol) -> Bool,
            lp: LogicOp) -> (BookProtocol) -> Bool {
    if (lp == .and) {
        return { (book: BookProtocol) -> Bool in
            func1(book) && func2(book) }
    } else {
        return { (book: BookProtocol) -> Bool in
            func1(book) || func2(book) }
    }
}

func ClosureSequenceCreate(conditions: [Condition], logicOps: [LogicOp]) -> ((BookProtocol) -> Bool)? {
    if var seq: (BookProtocol) -> Bool = conditions[0].createClosure() {
        if (logicOps.count == 0) {
            return seq
        } else {
            for (i, cnd) in conditions.enumerated().dropFirst() {
                if let f2 = cnd.createClosure() {
                    seq = Append(func1: seq, func2: f2, lp: logicOps[i - 1])
                } else {
                    return nil
                }
            }
        }
        
        return seq
    } else {
        return nil
    }
}
