//
//  ListController.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import UIKit

final class ListController: UITableViewController {
    
    var viewModel: ListViewModel!
    var router: ListRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.table = tableView
        viewModel.didSelect = { [weak self] article in
            self?.router.navigate(.toDetails(passingArticle: article))
        }
        viewModel.load()
    }
}

