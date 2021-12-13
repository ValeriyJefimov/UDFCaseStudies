//
//  Router.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import UIKit
import Dip

protocol StoryboardIdentifiable {
  var storyboardIdentifier: String { get }
}

protocol Router {
  associatedtype Segue: StoryboardIdentifiable
  var container: DependencyContainer { get }
  var controller: UIViewController { get }
  func navigate(_ segue: Segue)
}

class BaseRouter {
  let container: DependencyContainer
  unowned let controller: UIViewController
  
  init(container: DependencyContainer, controller: UIViewController) {
    self.container = container
    self.controller = controller
  }
}


