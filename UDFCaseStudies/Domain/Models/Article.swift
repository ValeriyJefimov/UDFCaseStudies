//
//  Article.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation

protocol Article {
    var author: String? { get set }
    var title: String? { get set }
}

struct DescriptionedArticle: Article, Codable, Equatable, Hashable {
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
    }
    
    var id: UUID
    var author: String?
    var title: String?
    var description: String?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        id = UUID()
    }
    
    init(id: UUID,
         author: String?,
         title: String?,
         description: String?) {
        self.id = id
        self.author = author
        self.title = title
        self.description = description
    }
}

struct ImagedArticle: Article, Codable, Equatable, Hashable {
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case urlToImage
    }
    
    var id: UUID
    var author: String?
    var title: String?
    var urlToImage: URL?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        title = try values.decodeIfPresent(String.self, forKey: .title)

        if let string = try? values.decodeIfPresent(String.self, forKey: .urlToImage),
           let percentEncoded = string
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: percentEncoded) {
            self.urlToImage = url
        } else {
            self.urlToImage = nil
        }
        
        id = UUID()
    }
}
