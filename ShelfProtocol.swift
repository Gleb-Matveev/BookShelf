//
//  Shelfable.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation

protocol ShelfProtocol {
    func add(book: BookProtocol) -> Result<Void, Error>
    func delete(id: UUID) -> Result<BookProtocol, Error>
    func getByCreteria(creteria: (BookProtocol) -> Bool) -> [BookProtocol]
    func display()
}
