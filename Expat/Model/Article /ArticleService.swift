import Foundation

enum Errors: Error {
    case noData, noResponse, undecodable
}

final class ArticleService {
    
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    // MARK: - Methods
    
    // step 1: creation of the request, currency allows to choose the exchange currency
    func getArticle(keyword:String, callback: @escaping (Result<Article,Error>) -> Void) {
        
        guard let articleUrl = URL(string: "https://api.newscatcherapi.com/v2/search?lang=fr&sort_by=date&page_size=10&q=\(keyword)")
        else { return }
        
        var request = URLRequest(url: articleUrl)
        request.setValue("mr-tw6Rmlcy5bFm--X2e47pjXQUo7QnTDjYiwPBLTk0", forHTTPHeaderField: "x-api-key")
        
        task?.cancel()
         task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(Errors.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(Errors.noResponse))
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(Article.self, from: data) else { // responseJSON.rates
                        callback(.failure(Errors.undecodable))
                        return
                }
            callback(.success(responseJSON))
            
        }
        task?.resume()
        
    }
    
}
