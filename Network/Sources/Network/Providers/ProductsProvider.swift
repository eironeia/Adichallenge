import Foundation
import Domain

public struct ProductsProvider: APIInterface, ProductsProviderInterface {
    public init() {

    }

    public func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        fetch(ProductsEndpoint.products) { (result: (Result<[Product], Error>)) in
            switch result {
            case let .success(products):
                completion(.success(products))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
