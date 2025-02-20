//
//  main.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation

/*
var bookShelf1 = BookShelf(_books: bookShelf.getByCreteria(creteria: {(book: any Book) -> Bool in
    if book.title == "Dad" || book.title == "Mother" {
        return true
    } else {
        return false
    }
}))
*/

var book1 = BaseBook(id: UUID.init(), title: "Three friends", author: "Glebka", publicationYear: Date(), genre: Genre.novel)
var book2 = BaseBook(id: UUID.init(), title: "Laptop", author: "Misha", publicationYear: Date(), genre: Genre.mystery)
var book3 = BaseBook(id: UUID.init(), title: "Cable", author: "Kirill", publicationYear: Date(), genre: Genre.novel)
var book4 = BaseBook(id: UUID.init(), title: "Mother", author: "Razor", publicationYear: Date(), genre: Genre.novel)
var book5 = BaseBook(id: UUID.init(), title: "Dad", author: "Agro", publicationYear: Date(), genre: Genre.thriller)
var book6 = BaseBook(id: UUID.init(), title: "Doctor", author: "Masha", publicationYear: Date(), genre: Genre.fiction)
var comics = BaseComics(id: UUID.init(), issueNumber: 30, title: "Doctor", author: "Masha", publicationYear: Date(), genre: Genre.fiction)
var textBook = BaseTextBook(id: UUID.init(), courseYear: 4, title: "Doctor", author: "Masha", publicationYear: Date(), genre: Genre.fiction)
var bookShelf = BookShelf(_books: [book1.id: book1,
                                   book2.id: book2,
                                   book3.id: book3,
                                   book4.id: book4,
                                   book5.id: book5,
                                   book6.id: book6,
                                   comics.id: comics,
                                   textBook.id: textBook])
var isRunning = true

print("1 - Add Book\n2 - Delete Book\n3 - Show Books\n4 - Choose by creteria\n5 - Exit")
var input = readLine()


while (isRunning)
{
    switch input {
    case "1":
        print("Please input Title:")
        let title = readLine()
        print("Please input Author:")
        let author = readLine()
        print("Please input Genre:")
        let genre = readLine()
        
        if title != nil && author != nil && genre != nil {
            let newBook = BaseBook(id: UUID.init(), title: title!, author: author!, publicationYear: Date(), genre: Genre(name: genre!))
            bookShelf.add(book: newBook)
        } else {
            print("Sorry wrong incomplete or wrong input\n")
        }
    case "2":
        print("Input books id: ")
        let id = readLine()
        if id != nil {
            if let iid = UUID(uuidString: id!) {
                bookShelf.delete(id: iid)
            } else {
                print("Sorry, wrong id\n")
            }
        } else {
            print("Sorry, incorrect input\n")
        }
    case "3":
        bookShelf.display()
    case "4":
        print("Input condition: ")
        if let condition = readLine() {
            let conditions = ParseCondition(condition: condition)
            let scc: SequenceClosureCreator = SequenceClosureCreator()
            if conditions != nil {
                if let uconditions = conditions {
                    let closures = scc.SequenceClosureCreate(conditions: uconditions.0, logicOps: uconditions.1)
                    let bookShelf1 = BookShelf(_books: bookShelf.getByCreteria(creteria: closures))
                    print("\nBooks that meat your criteria: ")
                    bookShelf1.display()
                }
            }
        }
    case "5":
        exit(0)
    default:
        print("Sorry, incorrect input\n")
    }
    
    print("1 - Add Book\n2 - Delete Book\n3 - Show Books\n4 - Choose by creteria\n5 - Exit")
    input = readLine()
}

//Title == Doctor && Author == Masha
