//
//  NetworkRepositoryType.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation
import Combine

protocol NetworkRepositoryType {
    var observeAEArticles: AnyPublisher<DescriptionedArticleResponse, NetworkError> { get }
    var observeAppleArticles: AnyPublisher<ImagedArticleResponse, NetworkError> { get }
}

protocol NetworkRepositoryHolderType {
  var networkRepo: NetworkRepositoryType { get }
}
