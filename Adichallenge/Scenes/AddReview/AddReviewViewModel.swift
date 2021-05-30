import Foundation
import RxSwift
import Domain

protocol AddReviewViewModelInterface {
    func transform(input: AddReviewViewModel.Input) -> AddReviewViewModel.Output
}

struct AddReviewViewModel: AddReviewViewModelInterface {
    let productId: String
    let useCase: ReviewsUseCaseInterface
    let onReviewAdded: (Review) -> Void
    let onCompletion: () -> Void

    private let isLoadingSubject = PublishSubject<Bool>()

    struct Input {
        let addReview: Observable<(text: String, score: Double)>
    }

    struct Output {
        let isLoading: Observable<Bool>
        let idle: Observable<Void>
    }

    func transform(input: Input) -> Output {
        let addReview = input
            .addReview
            .flatMapLatest { (text, score) -> Observable<Review> in
                Observable.create { observer in
                    let dto = ReviewDTO(productId: productId, locale: "en-US", rating: score, text: text)
                    useCase.addReview(reviewDTO: dto) { result in
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
            .do(onNext: onReviewAdded)
            .do(onNext: { _ in onCompletion() })
            .mapToVoid()

        return .init(isLoading: .empty(), idle: addReview)
    }
}

