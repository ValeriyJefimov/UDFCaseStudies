//
//  RootComposition.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import Foundation
import Dip

enum RootComposition {
    static func configure() -> DependencyContainer {
        let container = DependencyContainer()
        
        // World state dependencies
        DefaultsComposition.configure(container)
        
        // Scenes
        ListComposition.configure(container)
        DetailsComposition.configure(container)
        return container
    }
}

