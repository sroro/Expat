//
//  data.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 06/07/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let heytoi = try? newJSONDecoder().decode(Heytoi.self, from: jsonData)

import Foundation

// MARK: - Heytoi
struct Heytoi: Decodable {
    let status: String
    let totalHits, page, totalPages, pageSize: Int
    let articles: [Articles]
    let userInput: UserInput

    enum CodingKeys: String, CodingKey {
        case status
        case totalHits = "total_hits"
        case page
        case totalPages = "total_pages"
        case pageSize = "page_size"
        case articles
        case userInput = "user_input"
    }
}

// MARK: - Article
struct Articles: Decodable {
    let title, author, publishedDate, publishedDatePrecision: String
    let link: String
    let cleanURL, excerpt, summary, rights: String
    let rank: Int
    let topic, country, language, authors: String
    let media: String
    let isOpinion: Bool
    let twitterAccount: JSONNull?
    let score: Double
    let id: String

    enum CodingKeys: String, CodingKey {
        case title, author
        case publishedDate = "published_date"
        case publishedDatePrecision = "published_date_precision"
        case link
        case cleanURL = "clean_url"
        case excerpt, summary, rights, rank, topic, country, language, authors, media
        case isOpinion = "is_opinion"
        case twitterAccount = "twitter_account"
        case score = "_score"
        case id = "_id"
    }
}

// MARK: - UserInput
struct UserInput: Decodable {
    let q: String
    let searchIn, lang: [String]
    let notLang, countries, notCountries: JSONNull?
    let from: String
    let to: JSONNull?
    let rankedOnly: String
    let fromRank, toRank: JSONNull?
    let sortBy: String
    let page, size: Int
    let sources, notSources, topic, publishedDatePrecision: JSONNull?

    enum CodingKeys: String, CodingKey {
        case q
        case searchIn = "search_in"
        case lang
        case notLang = "not_lang"
        case countries
        case notCountries = "not_countries"
        case from, to
        case rankedOnly = "ranked_only"
        case fromRank = "from_rank"
        case toRank = "to_rank"
        case sortBy = "sort_by"
        case page, size, sources
        case notSources = "not_sources"
        case topic
        case publishedDatePrecision = "published_date_precision"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


