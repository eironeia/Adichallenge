import Foundation

// Rename to product.currency
enum Currency: String, Codable {
    case dollar = "$"
}

struct DiscoverProductUIModel {
    let id: String
    let imageURL: String
    let name: String
    let description: String
    let price: Int
    let currency: Currency
}
