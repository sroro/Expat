//
//  appel.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 06/07/2022.
//

import Foundation

enum erreur: Error {
    case noData, noResponse, unDecodable
}
final class testss {
func appels(callback: @escaping (Result<Heytoi, Error>) -> Void) {
    
    guard let url = URL(string: "https://api.newscatcherapi.com/v2/search?lang=fr&q=malte&page_size=1") else { return }
    var request = URLRequest(url: url)
    request.setValue("HOuvKGWFpvqPicSANNKUVZ59Dte1d0U32jQg2X9qVy4", forHTTPHeaderField: "x-api-key")
    
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data,error == nil else {
            callback(.failure(erreur.noData))
            return
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            callback(.failure(erreur.noResponse))
            return
        }
        
        guard let responseJSON = try? JSONDecoder().decode(Heytoi.self, from: data) else {
                    callback(.failure(erreur.unDecodable))
                    return
            }
        callback(.success(responseJSON))

    }.resume()
}
}
