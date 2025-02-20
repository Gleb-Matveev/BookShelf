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
    case Title(String)
    case Author(String)
    case PubYear(Date)
    case Genre(Genre)
}

struct Condition {
    var sign: Sign
    var prop: Property
    
    // init() проверка на возможноссть существования
}

extension Condition {
    func createClosure() -> (Book) -> Bool {
        switch sign {
        case .gt:
            if case let .PubYear(pubYear) = prop {
                return { (book: Book) -> Bool in
                    return book.publicationYear > pubYear
                }
            }
        case .lt:
            if case let .PubYear(pubYear) = prop {
                return { (book: Book) -> Bool in
                    return book.publicationYear < pubYear
                }
            }
        case .eq:
            switch prop {
            case .Title(let title):
                return { (book: Book) -> Bool in
                    return book.title == title
                }
            case .Author(let author):
                return { (book: Book) -> Bool in
                    return book.author == author
                }
            case .PubYear(let pubYear):
                return { (book: Book) -> Bool in
                    return book.publicationYear == pubYear
                }
            case .Genre(let genre):
                return { (book: Book) -> Bool in
                    return book.genre == genre
                }
            }
        }
        // поменять
        return { (book: Book) -> Bool in
            return true
        }
    }
}
