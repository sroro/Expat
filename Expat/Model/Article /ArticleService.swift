//
//  ArticleService.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 04/07/2022.
//

import Foundation

enum Errors: Error {
    case noData, noResponse, undecodable
}

final class ArticleService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    
    // MARK: - Methods
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    func getArticle(callback: @escaping (Result<Article, Error>) -> Void) {
        guard let articleUrl = URL(string: "https://newsapi.org/v2/everything?apiKey=0188fbcc14d94b91a7558fc4763e564b&sortBy=publishedAt&q=espagne")
        else { return }
        
        task?.cancel()
    
        task = session.dataTask(with: articleUrl) { (data, response, error) in

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
            guard let responseJSON = try? JSONDecoder().decode(Article.self, from: data) else {
                        callback(.failure(Errors.undecodable))
                        return
                }
                callback(.success(responseJSON))

            
        }
        task?.resume()
    }
}
