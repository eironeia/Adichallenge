import Foundation

public struct Product: Codable {
    public let id: String
    public let imageURL: String
    public let name: String
    public let description: String
    public let price: Double
    public let currency: String

    public init(
        id: String,
        imageURL: String,
        name: String,
        description: String,
        price: Double,
        currency: String
    ) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.description = description
        self.price = price
        self.currency = currency
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
