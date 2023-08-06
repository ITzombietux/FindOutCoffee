//
//  NetworkManager.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import Foundation

enum APIError: Error {
    case networkingError(Error)
    case serverError // HTTP 5xx
    case requestError(Int, String) // HTTP 4xx
    case invalidResponse
    case decodingError(DecodingError)
}

//"https://dapi.kakao.com/v2/local/search/keyword.json?query=카페&x=126.95738671650311&y=37.507476806640625&radius=1000&page=1"
class NetworkManager {
    private let session: URLSession
    private let baseURL = "https://dapi.kakao.com/v2/local/search"
    private let apiKey = "KakaoAK 6e23b996eb6c5652baa3a7979337eb33"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMapDocuments(page: Int, x: Double, y: Double, completion: @escaping (Result<MapResult, APIError>) -> Void) {

        let path = "/keyword.json?query=카페&x=\(x)&y=\(y)&radius=1000&page=\(page)"
        let allPath = baseURL+path
        guard let urlStr = allPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        perform(request: request, completion: parseDecodable(completion: completion))
    }
    
    private func parseDecodable<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void) -> (Result<Data, APIError>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let object = try jsonDecoder.decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(object))
                    }
                } catch let decodingError as DecodingError {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(decodingError)))
                    }
                }
                catch {
                    fatalError("Unhandled error raised.")
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func perform(request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(Result.failure(APIError.networkingError(error)))
                return
            }
            
            guard let http = response as? HTTPURLResponse, let data = data else {
                completion(Result.failure(APIError.invalidResponse))
                return
            }
            
            switch http.statusCode {
            case 200:
                completion(.success(data))
            case 400...499:
                let body = String(data: data, encoding: .utf8)
                completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))
                
            case 500...599:
                completion(.failure(.serverError))
            default:
                fatalError("Unhandled HTTP status code: \(http.statusCode)")
            }
        }
        task.resume()
    }
}
