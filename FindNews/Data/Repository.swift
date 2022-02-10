//
//  Repository.swift
//  FindNews
//
//  Created by Rita on 09.02.2022.
//

import Foundation

protocol RepositoryProtocol {
    
    func fetchData(url: String, completion: @escaping (_ answer: [Article]) -> ())
    func saveArticleToBD(_ article: Article)
    func removeArticleFromBD(_ article: Article)
    func fetchFavorite(completion: @escaping (_ favoriteArray: [Article]?) -> ())
}

class Repository: RepositoryProtocol {
    
    private let networkManager = NetworkManager()
    private let realmManager = RealmManager()
    
    func fetchData(url: String, completion: @escaping ([Article]) -> ()) {
        networkManager.fetchData(url: url) { (articlesDto) in
            let articles = articlesDto.map { (articleDto) in
                return Article(dto: articleDto)
            }
            completion(articles)
        }
    }
    
    func saveArticleToBD(_ article: Article) {
        let realmModel = RealmModel(article: article)
        realmManager.saveArticle(realmModel)
    }
    
    func removeArticleFromBD(_ article: Article) {
        
    }
    
    func fetchFavorite(completion: @escaping ([Article]?) -> ()) {
        realmManager.fetchArticle { (articlesRealm) in
            guard let articlesRealm = articlesRealm else { return }
            let articles = articlesRealm.map { (realmModel) in
                return Article(realmModel: realmModel)
            }
            completion(articles)
        }
    }
}
