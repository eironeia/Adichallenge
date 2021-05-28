import Foundation
import Domain

struct DiscoverProductUIModel: Equatable {
    let id: String
    let imageURL: String
    let name: String
    let description: String
    let price: Double
    let currency: String

    init(product: Product) {
        id = product.id
        imageURL = product.imageURL
        name = product.name
        description = product.description
        price = product.price
        currency = product.currency
    }
}
