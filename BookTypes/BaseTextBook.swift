//
//  BaseTextBook.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 14.02.2025.
//

import Foundation

struct BaseTextBook: TextBook {
    var id: UUID
    var courseYear: Int
    var title: String
    var author: String
    var publicationYear: Date
    var genre: Genre
    
    func display() {
        print("ID: \(self.id)")
        print("Title: \(self.title)")
        print("Course Year: \(self.courseYear)")
        print("Author: \(self.author)")
        print("Publication Year: \(self.publicationYear)")
        print("Genre: \(self.genre)")
        print("")
    }
}
