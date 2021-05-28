import XCTest
import Domain

final class MockProductsProvider: ProductsProviderInterface {
    var completionResult: Result<[Product], Error>!

    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        completion(completionResult)
    }
}
