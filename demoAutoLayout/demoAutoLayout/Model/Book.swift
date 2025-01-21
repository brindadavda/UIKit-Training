//
//  Book.swift
//  demoAutoLayout
//
//  Created by apple on 20/01/24.
//

import Foundation

struct Book{
    private let bookTitle : String!
    private let publicationDate : Date!
    private let pages : Int!
    private let author : String!
    private let finalPassEditor : String!
    
    
    init(bookTitle: String!, publicationDate: Date!, pages: Int!, author: String!, finalPassEditor: String!) {
        self.bookTitle = bookTitle
        self.publicationDate = publicationDate
        self.pages = pages
        self.author = author
        self.finalPassEditor = finalPassEditor
    }
}


