//
//  AppleArticleCell.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 12.12.2021.
//

import UIKit
import Kingfisher

class AppleArticleCell: UITableViewCell {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func configire(with article: ImagedArticle) {
        titleImage.kf.setImage(with: article.urlToImage)
        titleLabel.text = article.title
        subtitleLabel.text = article.author
    }
    
}
