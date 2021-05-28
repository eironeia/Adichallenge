import Foundation
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

    func transform(input: Input) -> Output {
        .init(
            isLoading: .empty(),
            products: .just(
                [
                    .init(
                        id: "1",
                        imageURL: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg",
                        name: "Name",
                        description: "Description",
                        price: 123, currency: .dollar
                    )
                ]
            )
        )
    }
}
