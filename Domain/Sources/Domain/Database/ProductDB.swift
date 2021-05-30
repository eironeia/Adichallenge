import Foundation

struct ProductDB: Codable {
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

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imgUrl"
        case name
        case description
        case price
        case currency
    }
}
