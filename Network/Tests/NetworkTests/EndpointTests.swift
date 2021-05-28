import XCTest
@testable import Network

final class EndpointsTest: XCTestCase {
    func test_getProducts() {
        let endpoint = ProductsEndpoint.products
        let urlRequest = endpoint.urlRequest

        XCTAssertEqual(
            urlRequest.url?.relativeString,
            "http://localhost:3001/product"
        )
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
}
