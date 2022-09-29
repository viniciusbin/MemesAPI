//
//  Service.swift
//  APImemes
//
//  Created by Vinicius on 15/09/22.
//

import Foundation
import Alamofire

enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error?)
    case network(Error?)
    case noData
}

class MemeService {
    let baseURL = "https://api.imgflip.com/get_memes"
    
    func getMeme(callback: @escaping (Result<Meme, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            callback(.failure(ServiceError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(ServiceError.network(error)))
                return
            }
            do {
                let meme = try? JSONDecoder().decode(Meme.self, from: data)
                guard let meme = meme else {
                    callback(.failure(ServiceError.noData))
                    return
                }
                callback(.success(meme))
            } catch {
                callback(.failure(ServiceError.decodeFail(error)))
            }
        }
        task.resume()
    }
}
