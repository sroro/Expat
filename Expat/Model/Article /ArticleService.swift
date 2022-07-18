import Foundation

enum Errors: Error {
    case noData, noResponse, undecodable
}

final class ArticleService {
    
    
    // MARK: - Methods
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    func getArticle(callback: @escaping (Result<Article, Error>) -> Void) {
        
        guard let articleUrl = URL(string: "https://api.newscatcherapi.com/v2/search?lang=fr&sort_by=date&page_size=10&q=espagne")
        else { return }
        
        var request = URLRequest(url: articleUrl)
        request.setValue("HOuvKGWFpvqPicSANNKUVZ59Dte1d0U32jQg2X9qVy4", forHTTPHeaderField: "x-api-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(Errors.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(NetworkErrorss.noResponse))
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(Article.self, from: data) else { // responseJSON.rates
                        callback(.failure(NetworkErrorss.undecodable))
                        return
                }
            callback(.success(responseJSON))
            
            
        }
        task.resume()
        
    }
    
}
