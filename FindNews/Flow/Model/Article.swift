//
//  File.swift
//  FindNews
//
//  Created by Rita on 09.02.2022.
//

import Foundation


struct Article {
    let source: String?
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    
    init(dto: ArticleDto) {
        self.source = dto.source.name
        self.author = dto.author
        self.title = dto.title
        self.description = dto.description
        self.url = dto.url
        self.urlToImage = dto.urlToImage
    }
    
    init(realmModel: RealmModel) {
        self.source = realmModel.source
        self.author = realmModel.author
        self.title = realmModel.title
        self.description = realmModel.description
        self.url = realmModel.url
        self.urlToImage = realmModel.urlToImage
    }
    
}
