//
//  Book.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 13.02.2025.
//

import Foundation

enum Genre {
    case novel, fiction, mystery, thriller, none
}

extension Genre {
    init(name: String) {
        switch name {
        case "novel":
            self = .novel
        case "fiction":
            self = .fiction
        case "mystery":
            self = .mystery
        case "thriller":
            self = .thriller
        default:
            self = .none
        }
    }
}

protocol BookProtocol {
    var id: UUID { get }
    var title: String { get }
    var author: String { get }
    var publicationYear: Date { get }
    var genre: Genre { get }
    
    func display()
}

