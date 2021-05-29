import Foundation

public struct ReviewDTO {
    public let productId: String
    public let locale: String
    public let rating: Double
    public let text: String

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

    public var asParameters: [String: Any] {
        [
            "productId": productId,
            "locale": locale,
            "rating": rating,
            "text": text
        ]
    }
}
