//
//  DataCity.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 31/05/2022.
//


import Foundation



// MARK: - Welcome
struct Welcome: Decodable {
    let data : [Data]
}

// MARK: - Datum
struct Data: Decodable {
    let id: Int
    let status, title, currency, studio, devise: String
    let repas, cafe, transport, cinema: String
    let essence, textBank, textCity: String
}
