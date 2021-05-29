import Foundation

public enum ReviewsEndpoint: EndpointInterface {
    case reviews(productId: String)

    public var urlRequest: URLRequest {
        var url = baseUrl
        url.appendPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        return urlRequest
    }

    private var baseUrl: URL {
        guard let url = URL(string: "http://localhost:3002/") else {
            preconditionFailure("Invalid URL used to create URL instance")
        }
        return url
    }

    private var path: String {
        switch self {
        case let .reviews(productId):
            return "reviews/\(productId)"
        }
    }

    private var httpMethod: String {
        switch self {
        case .reviews:
            return "GET"
        }
    }
}
