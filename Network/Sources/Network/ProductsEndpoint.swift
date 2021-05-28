import Foundation

public protocol EndpointInterface {
    var urlRequest: URLRequest { get }
}

public enum ProductsEndpoint: EndpointInterface {
    case products

    public var urlRequest: URLRequest {
        var url = baseUrl
        url.appendPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        return urlRequest
    }

    private var baseUrl: URL {
        guard let url = URL(string: "http://localhost:3001/") else {
            preconditionFailure("Invalid URL used to create URL instance")
        }
        return url
    }

    private var path: String {
        switch self {
        case .products:
            return "product"
        }
    }

    private var httpMethod: String {
        return "GET"
    }
}

