//
//  File.swift
//  FindNews
//
//  Created by Rita on 20.01.2022.
//

import Foundation

struct ApiModel: Decodable {
    let articles: [ArticleDto]
}

struct ArticleDto: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
}

struct Source: Decodable {
    let name: String?
}
