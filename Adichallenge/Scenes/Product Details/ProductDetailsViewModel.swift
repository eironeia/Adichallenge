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
        let addReview: Observable<Void>
    }

    struct Output {
        let isLoading: Observable<Bool>
        let sections: Observable<[Section]>
        let idle: Observable<Void>
    }

    let product: Product
    let useCase: ReviewsUseCaseInterface
    let onAddReview: (@escaping () -> Void) -> Void
    private let isLoadingSubject = PublishSubject<Bool>()
    private let fetchReviews = PublishSubject<Void>()

    init(
        product: Product,
        useCase: ReviewsUseCaseInterface,
        onAddReview: @escaping (@escaping () -> Void) -> Void
    ) {
        self.product = product
        self.useCase = useCase
        self.onAddReview = onAddReview
    }

    func transform(input: Input) -> Output {
        let sections = Observable
            .merge(input.showProduct, fetchReviews)
            .startLoading(loadingSubject: isLoadingSubject)
            .flatMapLatest(getReviews)
            .materialize()
            .compactMap { event -> [Review]? in
                switch event {
                case .next:
                    return event.element
                case let .error(error):
                    // TODO: Monitoring tool
                    debugPrint(error.localizedDescription)
                    return []
                default:
                    return event.element
                }
            }
            .map { $0.map(ReviewUIModel.init(review:)) }
            .map { reviewsUIModel -> [Section] in
                [.details(uiModel: .init(product: product)),
                 .reviews(reviewsUIModel)]
            }

            .stopLoading(loadingSubject: isLoadingSubject)

        let addReview = input
            .addReview
            .do(onNext: { _ in onAddReview(reviewAdded) })

        return .init(isLoading: isLoadingSubject, sections: sections, idle: addReview)
    }
}

private extension ProductDetailsViewModel {
    func getReviews() -> Observable<[Review]> {
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

    func reviewAdded() {
        fetchReviews.onNext(())
    }
}
