import Foundation
import Domain

extension LocalDatabase: ProductsDatabaseProviderInterface {
    public func getProducts() -> [Product]? {
        let data = storage.value(forKey: KeyIdentifier.products.rawValue) as? Data
        return try? data?.decoded()
    }

    public func save(products: [Product]) {
        let data = try? products.encoded()
        storage.set(data, forKey: KeyIdentifier.products.rawValue)
    }
}
