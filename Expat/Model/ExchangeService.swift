//
//  ExchangeService.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 02/06/2022.
//

import Foundation
enum NetworkError: Error {
    case noData, noResponse, undecodable
}

final class CurrencyService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    
    // MARK: - Methods
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    func getExchange(devise: String, callback: @escaping (Result<Double, Error>) -> Void) {
        guard  let exchangeUrl = URL(string: "https://api.currencyapi.com/v3/latest?apikey=dsNQaMatX3VUPGNUZjM5aq82OxTjReBRAMYsD3Tp&base_currency=EUR&currencies=\(devise)") else { return }
        
        task?.cancel()
        task = session.dataTask(with: exchangeUrl) { (data, response, error) in
            
            // check if data or error = nil else noData
                guard let data = data,error == nil  else {
                    callback(.failure(NetworkError.noData))
                    return
                }
                
                // check if the status code = 200 = OK else noResponse
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetworkError.noResponse))
                    return
                }
                // we decode the response received in JSON else error undecodable
            guard let responseJSON = try? JSONDecoder().decode(Symbol.self, from: data),
                  let currency = responseJSON.rates[devise] else { // responseJSON.rates
                        callback(.failure(NetworkError.undecodable))
                        return
                }
                callback(.success(currency))
            
        }
        task?.resume()
    }
}
