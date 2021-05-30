import Foundation

public protocol ProductsProviderInterface {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

public protocol ProductsDatabaseProviderInterface {
    func getProducts() -> [Product]?
    func save(products: [Product])
}

public protocol ReviewsProviderInterface {
    func getReviews(productId: String, completion: @escaping (Result<[Review], Error>) -> Void)
    func addReviews(reviewDTO: ReviewDTO, completion: @escaping (Result<Review, Error>) -> Void)
}
