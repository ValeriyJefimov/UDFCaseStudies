//
//  ObserveAEArticlesUseCase.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation
import Combine

protocol ObserveAEArticlesUseCase {
  var aeArticles: AnyPublisher<[DescriptionedArticle], NetworkError> { get }
}

extension ObserveAEArticlesUseCase where Self: NetworkRepositoryHolderType {
    var aeArticles: AnyPublisher<[DescriptionedArticle], NetworkError> {
        return networkRepo
            .observeAEArticles
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
}

