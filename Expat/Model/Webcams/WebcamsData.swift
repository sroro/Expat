//
//  WebcamsData.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 22/07/2022.

import Foundation

// MARK: - Webcams
struct Webcams: Decodable {
    let result: Resulty
}

// MARK: - Result
struct Resulty: Decodable {
    let total: Int
    let webcams: [Webcam]
}

// MARK: - Webcam
struct Webcam: Decodable {
    let title: String
    let image: Image
    let player: Player
    let id, status: String?
}

// MARK: - Image
struct Image: Decodable {
    let current: Current
    let sizes: Sizes
    let daylight: Current
    let update: Int
}

// MARK: - Current
struct Current: Decodable {
    let icon, thumbnail, preview, toenail: String
}

// MARK: - Sizes
struct Sizes: Decodable {
    let icon, thumbnail, preview, toenail: Icon
}

// MARK: - Icon
struct Icon: Decodable {
    let width, height: Int
}

// MARK: - Player
struct Player: Decodable {
    let day, month, year, lifetime: Day
}

// MARK: - Day
struct Day: Decodable {
    let available: Bool
    let link, embed: String
}





//// MARK: - Webcams
//struct Webcams: Decodable {
//    let result: Resulty
//}
//
//// MARK: - Result
//struct Resulty: Decodable {
//    let total: Int
//    let webcams: [Webcam]
//}
//
//// MARK: - Webcam
//struct Webcam: Decodable {
//    let id: String
//    let status: Status
//    let title: String
//    let url: URLClass
//}
//
//enum Status: String, Decodable {
//    case active = "active"
//}
//
//// MARK: - URLClass
//struct URLClass: Decodable {
//    let current: Current
//    let edit: String
//    let daylight: Current
//}
//
//// MARK: - Current
//struct Current: Decodable {
//    let desktop, mobile: String
//}


    

