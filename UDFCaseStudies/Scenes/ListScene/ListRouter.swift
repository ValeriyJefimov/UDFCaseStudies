//
//  ListRouter.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import Foundation

final class ListRouter: BaseRouter, Router {
  
  enum Segue {
      case toDetails(passingArticle: Article)
  }
  
  func navigate(_ segue: Segue) {
    switch segue {
    case .toDetails(let passingInfo):
      container.register { passingInfo }
      controller.performSegue(withIdentifier: segue.storyboardIdentifier, sender: nil)
    }
  }
}

extension ListRouter.Segue: StoryboardIdentifiable {
  var storyboardIdentifier: String {
    switch self {
    case .toDetails:
      return "toDetails"
    }
  }
}



