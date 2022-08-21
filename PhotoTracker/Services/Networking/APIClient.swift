//
//  APIClient.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

enum AuthMethod {
    case urlAccessKey(key: String, value: String)
    case accessKey(key: String, header: String)
    case `default`
}

class APIClient {
    let baseURL: String

    public init(baseURL: String) {
        self.baseURL = baseURL
    }

    var hostname: String {
        baseURL
    }

    func createSession(configuration: URLSessionConfiguration = URLSessionConfiguration.default) -> URLSession {
        URLSession(configuration: configuration)
    }
    
    var defaultAuth: AuthMethod? {
        return nil
    }
}

extension APIClient {
    enum Method: String {
        case get = "GET"
    }

    enum RequestError: Error {
        case invalidURL
        case invalidResponse
    }
}

extension APIClient: DataProvidable {
    func requestJSON(path: String, parameters: [String: Any]? = nil, method: APIClient.Method, auth: AuthMethod? = .default, result: @escaping (Result<Data, Error>) -> Void) {

        let background = DispatchQueue.global(qos: .background)

        background.async {
            guard var urlComponents = URLComponents(string: self.hostname + path) else {
                result(.failure(RequestError.invalidURL))
                return
            }

            if let parameters = parameters {
                urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
            }

            guard let url = urlComponents.url else {
                result(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            request = self.add(auth: auth, for: request)

            let session = self.createSession()
            let task = session.dataTask(with: request, completionHandler: { (data, _, error) in
                if let error = error {
                    result(.failure(error))
                } else if let data = data {
                    result(.success(data))
                } else {
                    result(.failure(RequestError.invalidResponse))
                }
            })
            
            task.resume()
        }
    }

    func add(auth: AuthMethod?, for request: URLRequest) -> URLRequest {

        guard let auth = auth else {
            return request
        }

        var request = request

        switch auth {
        case let .urlAccessKey(key, value):
            request.appendQueryItem(name: key, value: value)
        case let .accessKey(key, header):
            request.addValue(key, forHTTPHeaderField: header)
        case .default:
            if let defaultAuth = defaultAuth, case AuthMethod.default = defaultAuth {
                assertionFailure("*** Default auth cannot be .default. Use nil or prefered auth method.")
            }
            // In case of default, recursively ask for default auth
            request = add(auth: defaultAuth, for: request)
        }

        return request
    }
}

extension URLRequest {

    mutating func appendQueryItem(name: String, value: String?) {

        guard let url = self.url, var urlComponents = URLComponents(string: url.absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = URLRequest(url: urlComponents.url!)
    }
}
