import Foundation

public struct Review: Codable {
    public let productId: String
    public let locale: String
    public let rating: Double
    public let text: String

    enum CodingKeys: String, CodingKey {
        case productId
        case locale
        case rating
        case text
    }

    public init(
        productId: String,
        locale: String,
        rating: Double,
        text: String
    ) {
        self.productId = productId
        self.locale = locale
        self.rating = rating
        self.text = text
    }
}
