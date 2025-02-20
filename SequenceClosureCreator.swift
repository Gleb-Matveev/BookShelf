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

class SequenceClosureCreator {
    func Append(func1: @escaping (Book) -> Bool,
                func2: @escaping (Book) -> Bool,
                lp: LogicOp) -> (Book) -> Bool {
        if (lp == .and) {
            return { (book: Book) -> Bool in
                func1(book) && func2(book) }
        } else {
            return { (book: Book) -> Bool in
                func1(book) || func2(book) }
        }
    }
    
    func SequenceClosureCreate(conditions: [Condition], logicOps: [LogicOp]) -> (Book) -> Bool {
        var res: (Book) -> Bool = {
            (Book) -> Bool in
                true
        }
        
        for (i, cnd) in conditions.enumerated() {
            if (logicOps.count == 0) {
                res = Append(func1: res, func2: cnd.createClosure(), lp: LogicOp.and)
            } else {
                res = Append(func1: res, func2: cnd.createClosure(), lp: logicOps[i])
            }
        }
        
        return res
    }
}
