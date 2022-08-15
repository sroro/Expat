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

final class ExchangeService {
    
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
        guard let exchangeUrl = URL(string: "https://api.apilayer.com/fixer/latest?apikey=YU6Sbl0O6oDwhV5HZsZGGDlq00ePFh1W&base=EUR&symbols=\(devise)")
        else { return }
        
        task?.cancel()
        task = session.dataTask(with: exchangeUrl) { (data, response, error) in
            
            // check if data or error = nil else noData
                guard let data = data,error == nil  else {
                    callback(.failure(Errors.noData))
                    return
                }
                
                // check if the status code = 200 = OK else noResponse
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(Errors.noResponse))
                    return
                }
                // we decode the response received in JSON else error undecodable
             guard let responseJSON = try? JSONDecoder().decode(Exchange.self, from: data),
                    let currency = responseJSON.rates[devise] else { // responseJSON.rates
                        callback(.failure(Errors.undecodable))
                        return
                }
            callback(.success(currency))
            
        }
        task?.resume()
    }
}
