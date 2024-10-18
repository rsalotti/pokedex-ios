//
//  Network.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import Moya

open class Network<T:TargetType> {
    typealias Provider = MoyaProvider<T>
    let provider = Provider(plugins: [NetworkLoggerPlugin()])
    
    @discardableResult
    func execute<Model: Decodable>(route: T) async throws -> Model {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Model, Error>) in
            provider.request(route) { result in
                switch result {
                case .success(let response):
                    let data = response.data
                    do {
                        let model = try JSONDecoder().decode(Model.self, from: data)
                        continuation.resume(returning: model)
                    } catch let decodingError {
                        continuation.resume(throwing: decodingError)
                    }
                case .failure(let error): 
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
