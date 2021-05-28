import UIKit
import Domain

struct DiscoverProductsCoordinator {
    let presenter: UINavigationController
    let scenesFactory: DiscoverProductsFactoryInterface

    func start() {
        let viewController = scenesFactory
            .makeDiscoverProductsViewController(onSelectedProduct: navigateToSelectedProduct(product:))
        presenter.pushViewController(viewController, animated: true)
    }

    func navigateToSelectedProduct(product: Product) {
        let viewController = scenesFactory.makeProductDetailsViewController(product: product)
        presenter.pushViewController(viewController, animated: true)
    }
}
