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
        let idle: Observable<Void>
    }

    let useCase: ProductsUseCaseInterface
    let onSelectedProduct: (Product) -> Void
    private let isLoadingSubject = PublishSubject<Bool>()
    private let products = BehaviorSubject<[Product]>(value: [])

    func transform(input: Input) -> Output {
        let discoverProducts = input
            .fetchProducts
            .startLoading(loadingSubject: isLoadingSubject)
            .flatMapLatest { _ -> Observable<[Product]> in
                Observable.createFromResultCallback(useCase.getProducts)
            }
            .do(onNext: products.onNext(_:))
            .do(onError: { error in assertionFailure(error.localizedDescription) })
            .map { products in
                products.map(DiscoverProductUIModel.init(product:))
            }
            .stopLoading(loadingSubject: isLoadingSubject)

        let selectedProduct = input
            .selectedProduct
            .withLatestFrom(products, resultSelector: { id, products -> Product in
                guard let product = products.first(where: { $0.id == id }) else {
                    // This should not be a fatal error but instead a tracking
                    fatalError("There is no product with such id and it shouldn't")
                }
                return product
            })
            .do(onNext: onSelectedProduct)
            .mapToVoid()


        return .init(
            isLoading: isLoadingSubject,
            products: discoverProducts,
            idle: selectedProduct
        )
    }
}
