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

class BookShelf: Shelf {
    var books: [UUID: Book]
    var idCnt: Int = 0
    
    public init(_books: [UUID : Book]) {
        self.books = _books
    }
    
    public init(_books: [any Book]) {
        books = [:]
        
        for book in _books {
            _ = add(book: book)
        }
    }
    
    public func add(book: Book) -> Result<Void, Error> {
        books[book.id] = book
        return Result.success(())
    }
    
    public func delete(id: UUID) -> Result<Book, Error> {
        if let value = books.removeValue(forKey: id) {
            return Result.success(value)
        }
        return Result.failure(LibraryError.NoSuchValue)
    }
    
    
    public func getByCreteria(creteria: (Book) -> Bool) -> [any Book] {
        books.values.filter { book in
            return creteria(book)
        }
    }
    
    public func display() {
        for book in books/*.sorted(by: { $0.0 < $1.0 })*/ {
            book.value.display();
        }
    }
}
