//
//  ListComposition.swift
//  UDFCaseStudies
//
//  Created by Jefimov Valeriy on 06.12.2021.
//

import Foundation
import Dip

enum ListComposition {
    static func configure(_ container: DependencyContainer) {
        
        container.register {
            ListContext(networkRepo: $0)
        }
        .implements(ListViewModel.UseCases.self)
        
        container.register {
            ListViewModel(useCases: $0)
        }
        
        container
            .register(storyboardType: ListController.self, tag: "List")
            .resolvingProperties { container, controller in
                controller.viewModel = try container.resolve()
                controller.router = ListRouter(container: container, controller: controller)
            }
        
        DependencyContainer.uiContainers.append(container)
    }
}

extension ListController: StoryboardInstantiatable {}

// MARK: Context
private final class ListContext: NetworkRepositoryHolderType {
    
    let networkRepo: NetworkRepositoryType
    
    init(networkRepo: NetworkRepositoryType) {
        self.networkRepo = networkRepo
    }
}

extension ListContext: ObserveAppleArticlesUseCase {}
extension ListContext: ObserveAEArticlesUseCase {}
