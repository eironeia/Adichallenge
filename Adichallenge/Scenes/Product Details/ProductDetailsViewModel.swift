import Foundation
import RxSwift
import Domain

protocol ProductDetailsViewModelInterface {
    func transform(input: ProductDetailsViewModel.Input) -> ProductDetailsViewModel.Output
}

struct ProductDetailsViewModel: ProductDetailsViewModelInterface {
    enum Section {
        case details(uiModel: ProductDetailsUIModel)
        case reviews([ReviewUIModel])
    }

    struct Input {
        let showProduct: Observable<Void>
    }

    struct Output {
        let isLoading: Observable<Bool>
        let sections: Observable<[Section]>
    }

    let product: Product
    let useCase: ReviewsUseCaseInterface
    private let isLoadingSubject = PublishSubject<Bool>()

    func transform(input: Input) -> Output {
        let sections = input
            .showProduct
            .startLoading(loadingSubject: isLoadingSubject)
            .flatMapLatest { _ -> Observable<[Review]> in
                Observable.create { observer in
                    useCase.getReviews(productId: product.id) { result in
                        switch result {
                        case let .success(value):
                            observer.onNext(value)
                        case let .failure(error):
                            observer.onError(error)
                        }
                    }
                    return Disposables.create()
                }
            }
            .map { reviews in
                reviews.map(ReviewUIModel.init(review:))
            }
            .map { reviewsUIModel -> [Section] in
                [
                    .details(uiModel: .init(product: product)),
                    .reviews(reviewsUIModel)
                ]
            }
            .debug()
            .stopLoading(loadingSubject: isLoadingSubject)

        return .init(isLoading: isLoadingSubject, sections: sections)
    }
}
