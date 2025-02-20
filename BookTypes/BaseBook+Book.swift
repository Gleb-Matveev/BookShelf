//
//  BaseBook.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation

struct BaseBook: Book {
    var id: UUID
    var title: String
    var author: String
    var publicationYear: Date
    var genre: Genre
    
    func display() {
        print("ID: \(self.id)")
        print("Title: \(self.title)")
        print("Author: \(self.author)")
        print("Publication Year: \(self.publicationYear)")
        print("Genre: \(self.genre)")
        print("")
    }
}
