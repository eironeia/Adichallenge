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
        fetchProductsSubject = PublishSubject<Void>()
        selectedProductSubject = PublishSubject<String>()
        scheduler = TestScheduler(initialClock: 0)
        isLoadingObserver = scheduler.createObserver(Bool.self)
        selectedProductObserver = scheduler.createObserver(String.self)
        productsObserver = scheduler.createObserver([DiscoverProductUIModel].self)
        disposeBag = DisposeBag()
        sut = DiscoverProductsViewModel(useCase: productsUseCase, onSelectedProduct: { _ in })
    }

    override func tearDown() {
        productsUseCase = nil
        scheduler = nil
        disposeBag = nil
        sut = nil
        super.tearDown()
    }

    func test_whenFetchProductsEvent() {
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

        let input = createInput(fetchProducts: fetchProductsSubject)
        let output = sut.transform(input: input)

        subscribeOutput(output: output)
        scheduler.start()

        XCTAssertEqual(
            isLoadingObserver.events,
            [
                .next(10, true),
                .next(10, false)
            ]
        )

        XCTAssertEqual(productsObserver.events, [.next(10, [expectedUIModel])])
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

    func createInput(
        fetchProducts: Observable<Void> = .empty(),
        selectedProduct: Observable<String> = .empty(),
        filterProducts: Observable<String?> = .empty()
    ) -> DiscoverProductsViewModel.Input {
        .init(fetchProducts: fetchProducts, selectedProduct: selectedProduct, filterProducts: filterProducts)
    }
}
