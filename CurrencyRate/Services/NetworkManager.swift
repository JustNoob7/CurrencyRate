//
//  NetworkManager.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrencies(from url: String, with completion: @escaping(Result<CurrenciesInfo, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let currenciesInfo = try JSONDecoder().decode(CurrenciesInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(currenciesInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
