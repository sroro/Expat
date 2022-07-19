//
//  ArticleData.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 04/07/2022.
//




// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let article = try? newJSONDecoder().decode(Article.self, from: jsonData)

import Foundation

// MARK: - Article
struct Article: Decodable {
    let articles: [ArticleElement]
}

// MARK: - ArticleElement
struct ArticleElement: Decodable {
    let title: String
    let publishedDate: String?
    let link: String?
    let excerpt, summary, rights: String?
    let media: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case publishedDate = "published_date"
        case link
        case excerpt, summary, media, rights
}
}
