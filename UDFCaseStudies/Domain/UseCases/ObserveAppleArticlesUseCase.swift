//
//  ObserveAppleArticlesUseCase.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation
import Combine

protocol ObserveAppleArticlesUseCase {
  var appleArticles: AnyPublisher<[ImagedArticle], NetworkError> { get }
}

extension ObserveAppleArticlesUseCase where Self: NetworkRepositoryHolderType {
    var appleArticles: AnyPublisher<[ImagedArticle], NetworkError> {
        return networkRepo
            .observeAppleArticles
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
}

