//
//  NetworkRepo.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation
import Combine

enum NetworkError: Error {
    case wrongResponse
}

final class NetworkRepository: NetworkRepositoryType {
    private let urlSession = URLSession.shared
    private lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
 
    var observeAEArticles: AnyPublisher<DescriptionedArticleResponse, NetworkError> {
        return urlSession
            .dataTaskPublisher(for: createURL(with: "American Eagle"))
            .tryMap() { $0.data }
            .decode(type: DescriptionedArticleResponse.self, decoder: JSONDecoder())
            .mapError { _ in .wrongResponse }
            .eraseToAnyPublisher()
    }
    
    var observeAppleArticles: AnyPublisher<ImagedArticleResponse, NetworkError> {
        return urlSession
            .dataTaskPublisher(for: createURL(with: "Apple"))
            .tryMap() { $0.data }
            .decode(type: ImagedArticleResponse.self, decoder: JSONDecoder())
            .mapError { error in
                print(error)
                return .wrongResponse }
            .eraseToAnyPublisher()
    }
    
    private func createURL(with q: String) -> URL {
        var dayComponent = DateComponents()
        dayComponent.day = -7
        let theCalendar = Calendar.current
        let weekBeforeDate = theCalendar.date(byAdding: dayComponent, to: Date())
        let dateStr = dateFormatter.string(from: weekBeforeDate ?? Date())
        var urlComp = URLComponents(string: "https://newsapi.org/v2/everything?sortBy=publishedAt&apiKey=1ce8850cbb6c4587960a223662a59a33")
        urlComp?.queryItems?.append(URLQueryItem(name: "q", value: q))
        urlComp?.queryItems?.append(URLQueryItem(name: "from", value: dateStr))
        return urlComp!.url!
    }
}
