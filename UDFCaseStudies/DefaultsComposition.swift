//
//  DefaultsComposition.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import Foundation
import Dip

/// Home of world state dependencies
enum DefaultsComposition {
  static func configure(_ container: DependencyContainer) {
    
    // NetworkRepo
    container.register(.singleton) {
      NetworkRepository()
    }
    .implements(NetworkRepositoryType.self)
  }
}

