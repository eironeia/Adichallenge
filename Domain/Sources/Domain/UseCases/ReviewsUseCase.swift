import Foundation

public protocol ReviewsUseCaseInterface {
    func getReviews(productId: String, completion: @escaping (Result<[Review], Error>) -> Void)
}

public struct ReviewsUseCase: ReviewsUseCaseInterface {
    public typealias GetReviewsClosure = (Result<[Review], Error>) -> Void

    private let reviewsProvider: ReviewsProviderInterface

    public init(
        reviewsProvider: ReviewsProviderInterface
    ) {
        self.reviewsProvider = reviewsProvider
    }

    public func getReviews(productId: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        // TODO: Database persistance + fetching if there is no connection
        reviewsProvider.getReviews(productId: productId, completion: completion)
    }
}
