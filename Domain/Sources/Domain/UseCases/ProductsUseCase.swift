import Foundation

public protocol ProductsUseCaseInterface {
    func getProducts(completion: @escaping ProductsUseCase.GetProductsClosure)
}

public struct ProductsUseCase: ProductsUseCaseInterface {
    public typealias GetProductsClosure = (Result<[Product], Error>) -> Void

    private let productsProvider: ProductsProviderInterface
    private let productsDatabase: ProductsDatabaseProviderInterface

    public init(
        productsProvider: ProductsProviderInterface,
        productsDatabase: ProductsDatabaseProviderInterface
    ) {
        self.productsProvider = productsProvider
        self.productsDatabase = productsDatabase
    }

    public func getProducts(completion: @escaping ProductsUseCase.GetProductsClosure) {
        // TODO: Database persistance + fetching if there is no connection
        productsProvider.getProducts { result in
            switch result {
            case let .success(products):
                productsDatabase.save(products: products)
                completion(result)
            default:
                completion(result)
            }
        }
    }
}
