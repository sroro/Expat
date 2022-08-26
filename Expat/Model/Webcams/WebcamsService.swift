//
//  WebcamsService.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 22/07/2022.
//

import Foundation


final class WebcamsService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    // MARK: - Methods
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    func getWebcams(countryCode:String, callback: @escaping (Result<Webcams,Error>) -> Void) {
        
        guard let articleUrl = URL(string: "https://api.windy.com/api/webcams/v2/list/country=\(countryCode)/orderby=popularity//limit=20?show=webcams:player,image")
        else { return }
        
        var request = URLRequest(url: articleUrl)
        request.setValue("GSsJ5fj5Jgi9rZuyUekmYDQWPrJHiUvS", forHTTPHeaderField: "x-windy-key")
        
        task?.cancel()
        
        task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(Errors.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(NetworkErrorss.noResponse))
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(Webcams.self, from: data) else { // responseJSON.rates
                        callback(.failure(NetworkErrorss.undecodable))
                        return
                }
            callback(.success(responseJSON))
            
            
        }
        task?.resume()
        
    }
    
}
