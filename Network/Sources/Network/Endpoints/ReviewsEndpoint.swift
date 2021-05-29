import Foundation
import Domain

public enum ReviewsEndpoint: EndpointInterface {
    case reviews(productId: String)
    case addReview(dto: ReviewDTO)

    public var urlRequest: URLRequest {
        var url = baseUrl
        url.appendPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = httpBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }

    private var baseUrl: URL {
        guard let url = URL(string: "http://localhost:3002/") else {
            preconditionFailure("Invalid URL used to create URL instance")
        }
        return url
    }

    private var httpBody: Data? {
        switch self {
        case .reviews: return nil
        case let .addReview(dto):
            let body = dto.asParameters
            let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            return data
        }
    }


    private var path: String {
        switch self {
        case let .reviews(productId):
            return "reviews/\(productId)"
        case let .addReview(dto):
            return "reviews/\(dto.productId)"
        }
    }

    private var httpMethod: String {
        switch self {
        case .reviews:
            return "GET"
        case .addReview:
            return "POST"
        }
    }
}
