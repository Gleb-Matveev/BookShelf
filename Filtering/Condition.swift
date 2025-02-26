//
//  Condition.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 20.02.2025.
//

import Foundation

enum Sign {
    case eq
    case gt
    case lt
}

enum Property {
    case title(String)
    case author(String)
    case pubYear(Date)
    case genre(Genre)
}

struct Condition {
    var sign: Sign
    var prop: Property
    
    init?(_sign: Sign, _prop: Property) {
        if _sign == .gt || _sign == .lt {
            if case .pubYear = _prop {
                self.sign = _sign
                self.prop = _prop
            } else {
                return nil
            }
        }
        
        self.sign = _sign
        self.prop = _prop
    }
}

extension Condition {
    func createClosure() -> ((BookProtocol) -> Bool)? {
        switch sign {
        case .gt:
            if case let .pubYear(pubYear) = prop {
                return {(book: BookProtocol) -> Bool in
                    return book.publicationYear > pubYear
                }
            }
        case .lt:
            if case let .pubYear(pubYear) = prop {
                return { (book: BookProtocol) -> Bool in
                    return book.publicationYear < pubYear
                }
            }
        case .eq:
            switch prop {
            case .title(let title):
                return { (book: BookProtocol) -> Bool in
                    return book.title == title
                }
            case .author(let author):
                return { (book: BookProtocol) -> Bool in
                    return book.author == author
                }
            case .pubYear(let pubYear):
                return { (book: BookProtocol) -> Bool in
                    return book.publicationYear == pubYear
                }
            case .genre(let genre):
                return { (book: BookProtocol) -> Bool in
                    return book.genre == genre
                }
            }
        }
        
        return nil
    }
}
