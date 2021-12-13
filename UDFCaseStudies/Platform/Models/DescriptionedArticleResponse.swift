//
//  ArticleResponse.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation

struct DescriptionedArticleResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [DescriptionedArticle]
}

struct ImagedArticleResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [ImagedArticle]
}
