//
//  BookShelf.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation
import SwiftUI
enum LibraryError: Error {
    case NoSuchValue
}

class BookShelf: ShelfProtocol {
    var books: [UUID: BookProtocol]
    var idCnt: Int = 0
    
    public init(_books: [UUID : BookProtocol]) {
        self.books = _books
    }
    
    public init(_books: [any BookProtocol]) {
        books = [:]
        
        for book in _books {
            _ = add(book: book)
        }
    }
    
    public func add(book: BookProtocol) -> Result<Void, Error> {
        books[book.id] = book
        return Result.success(())
    }
    
    public func delete(id: UUID) -> Result<BookProtocol, Error> {
        if let value = books.removeValue(forKey: id) {
            return Result.success(value)
        }
        return Result.failure(LibraryError.NoSuchValue)
    }
    
    
    public func getByCreteria(creteria: (BookProtocol) -> Bool) -> [any BookProtocol] {
        books.values.filter { book in
            return creteria(book)
        }
    }
    
    public func display() {
        for book in books {
            book.value.display();
        }
    }
}
