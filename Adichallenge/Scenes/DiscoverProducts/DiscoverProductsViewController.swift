import UIKit
import RxSwift
import RxCocoa
import PKHUD

struct DiscoverProductUIModel {}

protocol DiscoverProductsViewModelInterface {
    func transform(
        input: DiscoverProductsViewModel.Input
    ) -> DiscoverProductsViewModel.Output
}

struct DiscoverProductsViewModel: DiscoverProductsViewModelInterface {
    struct Input {
        let fetchProducts: Observable<Void>
    }

    struct Output {
        let products: Observable<[DiscoverProductUIModel]>
    }

    func transform(input: Input) -> Output {
        .init(products: .empty())
    }
}

final class DiscoverProductsViewController: UITableViewController {
    private var products: [DiscoverProductUIModel] = []
    private let viewModel: DiscoverProductsViewModelInterface
    private let fetchProductsSubject = PublishSubject<Void>()
    private lazy var disposeBag = DisposeBag()

    init(viewModel: DiscoverProductsViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupEvents()
        fetchProductsSubject.onNext(())
    }
}

private extension DiscoverProductsViewController {
    func setupUI() {
        title = "Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
//        tableView.register(
//            AlbumTitleCell.self,
//            forCellReuseIdentifier: AlbumTitleCell.identifier
//        )
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged
        )
    }

    func setupEvents() {
        let output = viewModel
            .transform(input: .init(fetchProducts: fetchProductsSubject))

//        output.products.asDriv
    }

    @objc
    func handleRefresh() {
        tableView.refreshControl?.endRefreshing()
        fetchProductsSubject.onNext(())
    }
}
