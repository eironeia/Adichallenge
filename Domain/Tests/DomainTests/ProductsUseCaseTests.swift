import XCTest
import Domain

class ProductsUseCaseTests: XCTestCase {
    var sut: ProductsUseCase!
    var mockProductsProvider: MockProductsProvider!

    override func setUp() {
        super.setUp()
        mockProductsProvider = MockProductsProvider()
        sut = ProductsUseCase(productsProvider: mockProductsProvider)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_whenGetProducts_thenSuccess() {
        mockProductsProvider.completionResult = .success([])
        let expectation = self.expectation(description: "Successful response called")
        sut.getProducts { result in
            switch result {
            case .success: expectation.fulfill()
            case .failure: XCTFail()
            }
        }
        waitForExpectations(timeout: 0.5)
    }

    func test_whenGetProducts_thenError() {
        mockProductsProvider.completionResult = .failure(NSError())
        let expectation = self.expectation(description: "Failure response called")
        sut.getProducts { result in
            switch result {
            case .success: XCTFail()
            case .failure: expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.5)
    }

    // TODO: Test data contract
    
}


