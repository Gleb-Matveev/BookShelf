//
//  main.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation

var book1 = Book(id: UUID.init(), title: "Three friends", author: "Glebka", publicationYear: Date(), genre: Genre.novel)
var book2 = Book(id: UUID.init(), title: "Laptop", author: "Misha", publicationYear: Date(), genre: Genre.mystery)
var book3 = Book(id: UUID.init(), title: "Cable", author: "Kirill", publicationYear: Date(), genre: Genre.novel)
var book4 = Book(id: UUID.init(), title: "Mother", author: "Razor", publicationYear: Date(), genre: Genre.novel)
var book5 = Book(id: UUID.init(), title: "Dad", author: "Agro", publicationYear: Date(), genre: Genre.thriller)
var book6 = Book(id: UUID.init(), title: "Doctor", author: "Masha", publicationYear: Date(), genre: Genre.fiction)
var comics = Comics(id: UUID.init(), issueNumber: 30, title: "Doctor", author: "Masha", publicationYear: Date(), genre: Genre.fiction)
var textBook = TextBook(id: UUID.init(), courseYear: 4, title: "Doctor", author: "Masha", publicationYear: Date(), genre: Genre.fiction)
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
        print("Please choose what exctly you want to add: (1 - Book, 2 - Comics, 3 - TextBook)")
        let type = readLine()
        print("Please input Title:")
        let title = readLine()
        print("Please input Author:")
        let author = readLine()
        print("Please input Genre:")
        let genre = readLine()
        
        if title != nil && author != nil && genre != nil {
            switch type {
            case "1":
                let newBook = Book(id: UUID.init(), title: title!, author: author!, publicationYear: Date(), genre: Genre(name: genre!))
                bookShelf.add(book: newBook)
            case "2":
                print("Please input issue number: ")
                if let str_in = readLine() {
                    if let issueNumber = Int(str_in) {
                        let newBook = Comics(id: UUID.init(), issueNumber: issueNumber, title: title!, author: author!, publicationYear: Date(), genre: Genre(name: genre!))
                        bookShelf.add(book: newBook)
                    }
                }
            case "3":
                print("Please input course year: ")
                if let str_cy = readLine() {
                    if let courseYear = Int(str_cy) {
                        let newBook = TextBook(id: UUID.init(), courseYear: courseYear, title: title!, author: author!, publicationYear: Date(), genre: Genre(name: genre!))
                        bookShelf.add(book: newBook)
                    }
                }
            default:
                print("Sorry wrong incomplete or wrong input\n")
            }
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
            if case .success(let parsed_conditions) = ParseCondition(condition: condition) {
                if let closure_seq = ClosureSequenceCreate(conditions: parsed_conditions.0, logicOps: parsed_conditions.1) {
                    let bookShelfTmp = BookShelf(_books: bookShelf.getByCreteria(creteria: closure_seq))
                    bookShelfTmp.display()
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
