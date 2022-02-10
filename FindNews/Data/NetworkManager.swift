//
//  NetworkManager.swift
//  FindNews
//
//  Created by Rita on 20.01.2022.
//

import Foundation

class NetworkManager {
    
    func fetchData(url: String, completion: @escaping (_ answer: [ArticleDto]) -> ()) {
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(ApiModel.self, from: data)
                let articles = json.articles
                completion(articles)
            } catch let error {
                print("error json \(error)")
            }
            
        }.resume()
    }
    
}


