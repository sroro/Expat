//
//  DataCity.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 31/05/2022.
//


import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let status, titre, currency, studio: String
    let cafe, essence, cinema, transport: String
    let repas, textBank, textTopCity: String

    enum CodingKeys: String, CodingKey {
        case id, status, titre, currency, studio, cafe, essence, cinema, transport, repas, textBank
        case textTopCity = "TextTopCity"
    }
}
