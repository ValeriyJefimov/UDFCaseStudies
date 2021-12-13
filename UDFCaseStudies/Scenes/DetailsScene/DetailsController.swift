//
//  DetailsController.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import UIKit

final class DetailsController: UIViewController {
    
    @IBOutlet weak var content: UILabel!
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.article.title
        content.text = viewModel.article.author
        
    }
}

