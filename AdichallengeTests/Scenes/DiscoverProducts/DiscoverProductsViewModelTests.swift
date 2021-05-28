import XCTest
import RxTest
import RxSwift
import Domain
@testable import Adichallenge

final class MockProductsUseCase: ProductsUseCaseInterface {
    var getProductsResult: Result<[Product], Error>!

    func getProducts(completion: @escaping ProductsUseCase.GetProductsClosure) {
        completion(getProductsResult)
    }
}

class DiscoverProductsViewModelTests: XCTestCase {
    var productsUseCase: MockProductsUseCase!
    var expectedProductUIModel: DiscoverProductUIModel!
    var fetchProductsObserver: TestableObserver<Void>!
    var selectedProductObserver: TestableObserver<String>!
    var isLoadingObserver: TestableObserver<Bool>!
    var productsObserver: TestableObserver<[DiscoverProductUIModel]>!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var sut: DiscoverProductsViewModel!

    var fetchProductsSubject: PublishSubject<Void>!
    var selectedProductSubject: PublishSubject<String>!

    override func setUp() {
        super.setUp()
        productsUseCase = MockProductsUseCase()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        sut = DiscoverProductsViewModel(useCase: productsUseCase)
    }

    override func tearDown() {
        productsUseCase = nil
        scheduler = nil
        disposeBag = nil
        sut = nil
        super.tearDown()
    }

    func test_whenFetchProductsEvent() {
        let fetchProductsSubject = PublishSubject<Void>()

        let product = Product(
            id: "id",
            imageURL: "https://www.google.com",
            name: "Name",
            description: "Description",
            price: 1,
            currency: "$"
        )

        let expectedUIModel = DiscoverProductUIModel(product: product)
        productsUseCase.getProductsResult = .success([product])

        bindSchedulers(fetchProductsEvent: [.next(10, ())])

        let output = sut
            .transform(
                input:
                    .init(
                        fetchProducts: fetchProductsSubject,
                        selectedProduct: .empty()
                    )
            )

        subscribeOutput(output: output)

        XCTAssertEqual(
            isLoadingObserver.events,
            [
                .next(10, true),
                .next(10, false)
            ]
        )

//        XCTAssertEqual(
//            productsObserver.events,
//            [
//                .next(10,    [expectedUIModel])
//            ]
//        )


        scheduler.start()
    }
}

private extension DiscoverProductsViewModelTests {
    func bindSchedulers(
        fetchProductsEvent: [Recorded<Event<Void>>] = [],
        selectedProductEvent: [Recorded<Event<String>>] = []
    ) {
        scheduler
            .createColdObservable(fetchProductsEvent)
            .bind(to: fetchProductsSubject)
            .disposed(by: disposeBag)

        scheduler
            .createColdObservable(selectedProductEvent)
            .bind(to: selectedProductSubject)
            .disposed(by: disposeBag)
    }

    func subscribeOutput(output: DiscoverProductsViewModel.Output) {
        output
            .isLoading
            .asDriverOnErrorJustComplete()
            .drive(isLoadingObserver)
            .disposed(by: disposeBag)

        output
            .products
            .asDriverOnErrorJustComplete()
            .drive(productsObserver)
            .disposed(by: disposeBag)
    }
}


extension Product: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
