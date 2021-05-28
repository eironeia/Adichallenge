import UIKit
import Domain
import Network

protocol DiscoverProductsFactoryInterface {
    func makeDiscoverProductsViewController(
        onSelectedProduct: @escaping (Product) -> Void
    ) -> UIViewController
    func makeProductDetailsViewController(product: Product) -> UIViewController
}

struct DiscoverProductsFactory: DiscoverProductsFactoryInterface {
    func makeDiscoverProductsViewController(
        onSelectedProduct: @escaping (Product) -> Void
    ) -> UIViewController {
        let provider = ProductsProvider()
        let useCase = ProductsUseCase(productsProvider: provider)
        let viewModel = DiscoverProductsViewModel(
            useCase: useCase,
            onSelectedProduct: onSelectedProduct
        )
        return DiscoverProductsViewController(viewModel: viewModel)
    }

    func makeProductDetailsViewController(product: Product) -> UIViewController {
        let viewModel = ProductDetailsViewModel(product: product)
        return ProductDetailsViewController(viewModel: viewModel)
    }
}
