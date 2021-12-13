//
//  DetailsComposition.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 07.12.2021.
//

import Foundation
import Dip

enum DetailsComposition {
    static func configure(_ container: DependencyContainer) {
    
        // View Models
        container.register {
            DetailsViewModel(article: $0)
        }
        
        // View Controller
        container
            .register(storyboardType: DetailsController.self, tag: "Details")
            .resolvingProperties { container, controller in
                controller.viewModel = try container.resolve()
            }
        
        DependencyContainer.uiContainers.append(container)
    }
}

extension DetailsController: StoryboardInstantiatable {}
