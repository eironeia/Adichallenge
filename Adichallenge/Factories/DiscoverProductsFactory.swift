import UIKit
import Domain
import Network

struct DiscoverProductsFactory {
    func makeDiscoverProductsViewController() -> UIViewController {
        let provider = ProductsProvider()
        let useCase = ProductsUseCase(productsProvider: provider)
        let viewModel = DiscoverProductsViewModel(useCase: useCase)
        return DiscoverProductsViewController(viewModel: viewModel)
    }
}
