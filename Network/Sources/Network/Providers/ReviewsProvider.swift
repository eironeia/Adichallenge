import Foundation
import Domain

public struct ReviewsProvider: APIInterface, ReviewsProviderInterface {
    public init() {}

    public func getReviews(productId: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        fetch(ReviewsEndpoint.reviews(productId: productId)) { (result: Result<[Review], Error>) in
            switch result {
            case let .success(products):
                completion(.success(products))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func addReviews(reviewDTO: ReviewDTO, completion: @escaping (Result<Review, Error>) -> Void) {
        fetch(ReviewsEndpoint.addReview(dto: reviewDTO)) { (result: Result<Review, Error>) in
            switch result {
            case let .success(products):
                completion(.success(products))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
