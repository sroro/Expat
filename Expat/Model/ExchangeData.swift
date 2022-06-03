//
//  ExchangeData.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 31/05/2022.
//

import Foundation
// MARK: - Welcome

// MARK: - Aed
struct Symbol: Decodable {
    let rates: [String:Double]
}
