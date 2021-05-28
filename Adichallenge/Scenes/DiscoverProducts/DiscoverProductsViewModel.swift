import Foundation
import Domain
import RxSwift

protocol DiscoverProductsViewModelInterface {
    func transform(
        input: DiscoverProductsViewModel.Input
    ) -> DiscoverProductsViewModel.Output
}

struct DiscoverProductsViewModel: DiscoverProductsViewModelInterface {
    struct Input {
        let fetchProducts: Observable<Void>
        let selectedProduct: Observable<String>
    }

    struct Output {
        let isLoading: Observable<Bool>
        let products: Observable<[DiscoverProductUIModel]>
    }

    let useCase: ProductsUseCaseInterface
    private let isLoadingSubject = PublishSubject<Bool>()

    func transform(input: Input) -> Output {
        let products = input
            .fetchProducts
            .startLoading(loadingSubject: isLoadingSubject)
            .flatMapLatest { _ -> Observable<[Product]> in
                Observable.createFromResultCallback(useCase.getProducts)
            }
            .map { products in
                products.map(DiscoverProductUIModel.init(product:))
            }
            .stopLoading(loadingSubject: isLoadingSubject)

        return .init(
            isLoading: isLoadingSubject,
            products: products
        )
    }
}
