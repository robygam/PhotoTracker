//
//  DataProvider.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

protocol DataProvidable {
    func requestJSON(path: String, parameters: [String: Any]?, method: APIClient.Method, auth: AuthMethod?, result: @escaping (Result<Data, Error>) -> Void)
}

/**
 Data Decoder manages data decoding. You need to provide a data provider that will be used to get data before decoding them
 */
class DataProvider {

    let provider: DataProvidable

    init(provider: DataProvidable) {
        self.provider = provider
    }

    static var defaultDecoder: JSONDecoder = JSONDecoder()

    func request<T: Codable>(path: String, parameters: [String: Any]? = nil, method: APIClient.Method, decoder: JSONDecoder = DataProvider.defaultDecoder, auth: AuthMethod? = .default, result: @escaping (Result<T, Error>) -> Void) {
        provider.requestJSON(path: path, parameters: parameters, method: method, auth: auth) { response in
            switch response {
            case .success(let data):
                do {
                    result(.success(try decoder.decode(T.self, from: data)))
                } catch {
                    result(.failure(DataError.serializationFailed))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}

enum DataError: Error {
    case serializationFailed
}
