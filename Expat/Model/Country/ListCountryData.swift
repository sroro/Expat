//
//  CollectionsAPI.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 14/06/2022.
//


import Foundation



// MARK: - WeatherTest
struct ListCountry: Decodable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Decodable {
    let collection: String
    let meta: Meta
}

// MARK: - Meta
struct Meta: Decodable {
    let collection: String
    let icon, note: String?

}




