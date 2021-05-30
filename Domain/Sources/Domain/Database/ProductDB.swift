import Foundation

struct ProductDB: Codable {
    let id: String
    let imageURL: String
    let name: String
    let description: String
    let price: Double
    let currency: String

    init(product: Product) {
        self.id = product.id
        self.imageURL = product.imageURL
        self.name = product.name
        self.description = product.description
        self.price = product.price
        self.currency = product.currency
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
