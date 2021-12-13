//
//  UseCasesTests.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 13.12.2021.
//

import XCTest
import Combine
@testable import UDFCaseStudies

fileprivate extension DescriptionedArticle {
    static let mock = DescriptionedArticle(id: UUID(),
                                           author: "AEO",
                                           title: "AEO Article title",
                                           description: "AEO Article Description")
}

fileprivate struct NetworkRepositoryMock: NetworkRepositoryType {
    var observeAEArticles: AnyPublisher<DescriptionedArticleResponse, NetworkError> {
        Just(DescriptionedArticleResponse(status: "ok",
                                          totalResults: 1,
                                          articles: [.mock]))
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    var observeAppleArticles: AnyPublisher<ImagedArticleResponse, NetworkError> {
        Just(ImagedArticleResponse(status: "ok",
                                   totalResults: 1,
                                   articles: []))
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

fileprivate struct ContextMock: NetworkRepositoryHolderType {
    var networkRepo: NetworkRepositoryType = NetworkRepositoryMock()
}

extension ContextMock: ObserveAEArticlesUseCase {}
extension ContextMock: ObserveAppleArticlesUseCase {}

class ObserveAEArticlesUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
         super.setUp()
         cancellables = []
     }

    func test_Observe_AEArticles_UseCase() {
        let useCase: ObserveAEArticlesUseCase = ContextMock()
        let expectation = self.expectation(description: "Awaiting articles")
        var error: Error?
        var articles = [DescriptionedArticle]()
        
        useCase
            .aeArticles
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let encounteredError):
                        error = encounteredError
                    }
                    expectation.fulfill()
                },
                receiveValue: { value in
                    articles = value
                }
            )
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
        XCTAssertNil(error)
        XCTAssertEqual(articles, [DescriptionedArticle.mock])
    }
}


