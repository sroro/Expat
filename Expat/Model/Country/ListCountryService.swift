//
//  CollectionsServices.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 14/06/2022.
//

import Foundation

enum NetworkErrorss: Error {
    case noData, noResponse, undecodable
}

final class ListCountryService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    
    func getList(callback: @escaping (Result<ListCountry, Error>) -> Void) {
        guard let cityUrl = URL(string: "https://svqfd01f.directus.app/collections")
        else { return }
        
        task?.cancel()
        task = session.dataTask(with: cityUrl) { (data, response, error) in
            
            // check if data or error = nil else noData
                guard let data = data,error == nil  else {
                    callback(.failure(NetworkErrorss.noData))
                    return
                }
                
                // check if the status code = 200 = OK else noResponse
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetworkErrorss.noResponse))
                    return
                }
                // we decode the response received in JSON else error undecodable
       
            guard let responseJSON = try? JSONDecoder().decode(ListCountry.self, from: data) else { // responseJSON.rates
                        callback(.failure(NetworkErrorss.undecodable))
                        return
                }
            callback(.success(responseJSON))
            
        }
        task?.resume()
    }
    
    
}
