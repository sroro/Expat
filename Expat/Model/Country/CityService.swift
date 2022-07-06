//
//  CityService.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 09/06/2022.
//

import Foundation

enum Errorss: Error {
    case noData, noResponse, undecodable
}

final class CityService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    
    // MARK: - Methods
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    func getCity(city: String, callback: @escaping (Result<Welcome, Error>) -> Void) {
        guard let cityUrl = URL(string: "https://svqfd01f.directus.app/items/\(city)")
        else { return }
        
        task?.cancel()
        task = session.dataTask(with: cityUrl) { (data, response, error) in
            
            // check if data or error = nil else noData
                guard let data = data,error == nil  else {
                    callback(.failure(Errorss.noData))
                    return
                }
                
                // check if the status code = 200 = OK else noResponse
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(Errorss.noResponse))
                    return
                }
                // we decode the response received in JSON else error undecodable
            guard let responseJSON = try? JSONDecoder().decode(Welcome.self, from: data) else {
                        callback(.failure(Errorss.undecodable))
                        return
                }
                callback(.success(responseJSON))
            
        }
        task?.resume()
    }
}
