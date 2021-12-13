//
//  ListViewModel.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import Foundation
import UIKit
import Combine

enum Section: Int {
   case first = 0
   case second
}

typealias TableDataSource = ArticlesTableViewDiffibleDataSource

class ListViewModel: NSObject {
    typealias UseCases = ObserveAppleArticlesUseCase & ObserveAEArticlesUseCase
    
    //MARK: - Private
    private var useCases: UseCases
    private var articles: [AnyHashable]
    private var dataSource: TableDataSource?
    private var cancellables = [AnyCancellable]()
    
    //MARK: - Public
    
    weak var table: UITableView? {
        didSet {
            if let table = table {
                dataSource = createDiffableDataSource(for: table)
            }
            table?.delegate = self
        }
    }
    var didSelect: ((Article) -> Void)?
 
    
    init(useCases: UseCases) {
        self.useCases = useCases
        self.table = nil
        self.didSelect = nil
        self.articles = []
    }
    
    func load() {
        
        useCases
            .aeArticles
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: didReceive(aeo:)
            )
            .store(in: &cancellables)
        
        useCases
            .appleArticles
            .receive(on: RunLoop.main)
            .delay(for: 2, scheduler: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: didReceive(apple:)
            )
            .store(in: &cancellables)
    }
}

extension ListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let section = Section(rawValue: indexPath.section),
           let article = dataSource?
            .snapshot()
            .itemIdentifiers(inSection: section)[safe: indexPath.row] as? Article {
            didSelect?(article)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension ListViewModel {
    func createDiffableDataSource(for table: UITableView) -> TableDataSource {
        return ArticlesTableViewDiffibleDataSource(
            tableView: table,
            cellProvider: { tableView, indexPath, model in
                
                if let model = model as? ImagedArticle {
                    return self.createAppleCell(for: table,
                           indexPath: indexPath,
                           model: model)
                }
                
                if let model = model as? DescriptionedArticle {
                    return self.createAEOCell(for: table,
                           indexPath: indexPath,
                           model: model)
                }
                return UITableViewCell()
            })
    }
    
    func didReceive(aeo articles: [DescriptionedArticle]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.appendSections([.first])
        snapshot.appendItems(articles, toSection: .first)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func didReceive(apple articles: [ImagedArticle]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.appendSections([.second])
        snapshot.appendItems(articles, toSection: .second)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func createAEOCell(for table: UITableView, indexPath: IndexPath, model: DescriptionedArticle) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "AEOCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = model.title
        content.secondaryText = model.author
        cell.contentConfiguration = content
        return cell
    }
    
    func createAppleCell(for table: UITableView, indexPath: IndexPath, model: ImagedArticle) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "AppleCell", for: indexPath) as! AppleArticleCell
        cell.configire(with: model)
        return cell
    }
}


class ArticlesTableViewDiffibleDataSource: UITableViewDiffableDataSource<Section, AnyHashable> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.snapshot()
            .itemIdentifiers(inSection: Section(rawValue: section) ?? .first)
            .first {
        case _ as ImagedArticle:
            return "APPLE"
        case _ as DescriptionedArticle:
            return "AEO"
        default:
            return nil
        }
    }

}
