import Foundation

public protocol ProductsUseCaseInterface {
    func getProducts(completion: @escaping ProductsUseCase.GetProductsClosure)
}

public struct ProductsUseCase: ProductsUseCaseInterface {
    public typealias GetProductsClosure = (Result<[Product], Error>) -> Void

    private let productsProvider: ProductsProviderInterface

    public init(
        productsProvider: ProductsProviderInterface
    ) {
        self.productsProvider = productsProvider
    }

    public func getProducts(completion: @escaping ProductsUseCase.GetProductsClosure) {
        // TODO: Database persistance + fetching if there is no connection
        productsProvider.getProducts(completion: completion)
    }
}
