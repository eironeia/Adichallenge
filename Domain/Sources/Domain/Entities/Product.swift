import Foundation

public struct Product: Codable {
    public let id: String
    public let imageURL: String
    public let name: String
    public let description: String
    public let price: Double
    public let currency: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imgUrl"
        case name
        case description
        case price
        case currency
    }
}
