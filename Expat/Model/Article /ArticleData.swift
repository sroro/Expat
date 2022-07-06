//
//  ArticleData.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 04/07/2022.
//

import Foundation


// MARK: - Article
struct Article: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleElement]
}

// MARK: - ArticleElement
struct ArticleElement: Decodable {
    let source: Source
    let author, title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Decodable {
    let name: String
}
