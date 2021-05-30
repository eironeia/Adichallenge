import UIKit
import Domain
import Network

protocol DiscoverProductsFactoryInterface {
    func makeDiscoverProductsViewController(
        onSelectedProduct: @escaping (Product) -> Void
    ) -> UIViewController
    func makeProductDetailsViewController(
        product: Product,
        onAddReview: @escaping (@escaping (Review) -> Void) -> Void
    ) -> UIViewController
    func makeAddReviewViewController(
        productId: String,
        onReviewAdded: @escaping (Review) -> Void,
        onCompletion: @escaping () -> Void
    ) -> UIViewController
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

    func makeProductDetailsViewController(
        product: Product,
        onAddReview: @escaping (@escaping (Review) -> Void) -> Void
    ) -> UIViewController {
        let provider = ReviewsProvider()
        let useCase = ReviewsUseCase(reviewsProvider: provider)
        let viewModel = ProductDetailsViewModel(product: product, useCase: useCase, onAddReview: onAddReview)
        return ProductDetailsViewController(viewModel: viewModel)
    }

    func makeAddReviewViewController(
        productId: String,
        onReviewAdded: @escaping (Review) -> Void,
        onCompletion: @escaping () -> Void
    ) -> UIViewController {
        let provider = ReviewsProvider()
        let useCase = ReviewsUseCase(reviewsProvider: provider)
        let viewModel = AddReviewViewModel(
            productId: productId,
            useCase: useCase,
            onReviewAdded: onReviewAdded,
            onCompletion: onCompletion
        )
        return AddReviewViewController(viewModel: viewModel)
    }
}
