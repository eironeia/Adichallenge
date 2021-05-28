import Foundation

public protocol ProductsProviderInterface {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
