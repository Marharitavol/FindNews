//
//  RealmModel.swift
//  FindNews
//
//  Created by Rita on 09.02.2022.
//

import Foundation
import RealmSwift

class RealmModel: Object {
    
    @objc dynamic var source = ""
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var articleDescription = ""
    @objc dynamic var url = ""
    @objc dynamic var urlToImage = ""
    
    convenience init(source: String, author: String, title: String, articleDescription: String, url: String, urlToImage: String) {
        self.init()
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
    }
    
    convenience init(article: Article) {
        self.init()
        self.source = article.source ?? ""
        self.author = article.author ?? ""
        self.title = article.title ?? ""
        self.articleDescription = article.description ?? ""
        self.url = article.url
        self.urlToImage = article.urlToImage ?? ""
    }
}
