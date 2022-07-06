//
//  WeatherService.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 23/06/2022.
//

import Foundation

final class WeatherService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    // MARK: - Methods
    
    ///Récupère conditions météorologique
    func getWeather(place: String, callback: @escaping (Result<Weather, Error> ) -> Void) {
        guard let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=314876d286f00bb721932b105fbb601b&units=metric&lang=fr&q=\(place)") else {return}
        
        task?.cancel()
        task = session.dataTask(with: weatherUrl, completionHandler: { (data, response, error) in
                
                guard let data = data, error == nil else {
                    callback(.failure(NetworkError.noData))
                    return
                }
            
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetworkError.noResponse))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(.failure(NetworkError.undecodable))
                    return
                }
                callback(.success(responseJSON))
        })
        task?.resume()
    }
}
