//
//  MessagesManager.swift
//  constraints_exercise_3
//
//  Created by Sofia Carena on 19/11/2021.
//

import Foundation


enum APIError: Error {
    case invalidResponse
    case wrongURL
    case fileNotFound
    case invalidData
    case decodingProblem(String)
    case serverError
    case pageNotFound
    case genericError
}

class MessagesManager {
    func retrieve(onCompletion: @escaping (Result<[Message], APIError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Bundle.main.url(forResource: "messages", withExtension: "json")
            guard let myUrl = url else {
                onCompletion(.failure(.fileNotFound))
                return
            }
            guard let myData = try? Data(contentsOf: myUrl) else {
                onCompletion(.failure(.invalidData))
                return
            }
            do {
                let superheros = try JSONDecoder().decode([Message].self, from: myData)
                onCompletion(.success(superheros))
            } catch DecodingError.dataCorrupted(_) {
                onCompletion(.failure(.decodingProblem("Data corrupted")))
            } catch DecodingError.keyNotFound(let codingKey, _) {
                onCompletion(.failure(.decodingProblem(codingKey.stringValue)))
            } catch let error {
                onCompletion(.failure(.decodingProblem(error.localizedDescription)))
            }
        }
    }
}
