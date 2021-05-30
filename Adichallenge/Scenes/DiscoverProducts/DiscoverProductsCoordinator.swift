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
        let viewController = scenesFactory.makeProductDetailsViewController(
            product: product,
            onAddReview: { onReviewAdded in
                navigateToAddReview(productId: product.id, onReviewAdded: onReviewAdded)
            }
        )
        presenter.pushViewController(viewController, animated: true)
    }

    func navigateToAddReview(productId: String, onReviewAdded: @escaping (Review) -> Void) {
        let viewController = scenesFactory
            .makeAddReviewViewController(
                productId: productId,
                onReviewAdded: onReviewAdded,
                onCompletion: {
                    DispatchQueue.main.async {
                        presenter.dismiss(animated: true)
                    }
                }
            )
        presenter.present(viewController, animated: true)
    }
}
