import Foundation

public struct Product: Codable {
    let id: String
    let imageURL: String
    let name: String
    let description: String
    let price: Double
    let currency: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imgURL"
        case name
        case description = "productDescription"
        case price
        case currency
    }
}
