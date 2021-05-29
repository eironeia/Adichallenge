import Foundation
import Domain

struct ReviewUIModel {
    let productId: String
    let locale: String
    let rating: Double
    let text: String

    public init(review: Review) {
        productId = review.productId
        locale = review.locale
        rating = review.rating
        text = review.text
    }
}
