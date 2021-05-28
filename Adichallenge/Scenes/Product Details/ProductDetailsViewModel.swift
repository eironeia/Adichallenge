import Foundation
import RxSwift
import Domain

protocol ProductDetailsViewModelInterface {
    func transform(input: ProductDetailsViewModel.Input) -> ProductDetailsViewModel.Output
}

struct ProductDetailsViewModel: ProductDetailsViewModelInterface {
    enum Section {
        case details(uiModel: ProductDetailsUIModel)
        case reviews
    }

    struct Input {
        let showProduct: Observable<Void>
    }

    struct Output {
        let sections: Observable<[Section]>
    }

    let product: Product

    func transform(input: Input) -> Output {
        let sections = input
            .showProduct
            .map { _ in product }
            .map { [Section.details(uiModel: ProductDetailsUIModel(product: $0))] }


        return .init(sections: sections)
    }
}
