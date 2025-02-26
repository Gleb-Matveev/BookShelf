//
//  TextBook.swift
//  L01_BookShelfConsole
//
//  Created by Gleb on 14.02.2025.
//

import Foundation

protocol TextBookProtocol: BookProtocol {
    var id: UUID { get }
    var courseYear: Int { get }
    var title: String { get }
    var author: String { get }
    var publicationYear: Date { get }
    var genre: Genre { get }
    
    func display()
}
