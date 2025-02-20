//
//  Shelfable.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation

protocol Shelf {
    func add(book: Book) -> Result<Void, Error>
    func delete(id: UUID) -> Result<Book, Error>
    func getByCreteria(creteria: (Book) -> Bool) -> [Book]
    func display()
}
