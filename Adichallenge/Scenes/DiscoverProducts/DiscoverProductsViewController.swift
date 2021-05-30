import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class DiscoverProductsViewController: UITableViewController {
    private var products: [DiscoverProductUIModel] = []
    private let viewModel: DiscoverProductsViewModelInterface
    private let fetchProductsSubject = PublishSubject<Void>()
    private let selectedProductSubject = PublishSubject<String>()
    private let filterProductsSubject = PublishSubject<String?>()
    private lazy var disposeBag = DisposeBag()

    private lazy var searchBar = UISearchBar()

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
        title = "Adidas products"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.register(
            DiscoverProductCell.self,
            forCellReuseIdentifier: DiscoverProductCell.identifier
        )
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged
        )

        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    func setupEvents() {
        let output = viewModel.transform(
            input:
            .init(
                fetchProducts: fetchProductsSubject,
                selectedProduct: selectedProductSubject,
                filterProducts: filterProductsSubject
            )
        )

        output
            .isLoading
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] isLoading in
                self?.handle(isLoading: isLoading)
            })
            .disposed(by: disposeBag)

        output
            .products
            .do(onError: { [weak self] _ in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops!", message: "Something went wrong, try again later", preferredStyle: .alert)
                    self?.present(alert, animated: true, completion: nil)
                }
            })
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] products in
                self?.handle(discoverProducts: products)
            })
            .disposed(by: disposeBag)

        output
            .idle
            .asDriverOnErrorJustComplete()
            .drive()
            .disposed(by: disposeBag)
    }

    func handle(discoverProducts: [DiscoverProductUIModel]) {
        products = discoverProducts
        tableView.reloadData()
    }

    func handle(isLoading: Bool) {
        isLoading
            ? HUD.show(.progress, onView: view)
            : HUD.hide()
    }
}

// MARK: - Datasource

extension DiscoverProductsViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return products.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.cell(as: DiscoverProductCell.self)
        let productUIModel = products[indexPath.row]
        cell.setup(uiModel: productUIModel)
        return cell
    }
}

// MARK: - Delegate

extension DiscoverProductsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let productId = products[indexPath.row].id
        selectedProductSubject.onNext(productId)
    }

    @objc
    func handleRefresh() {
        tableView.refreshControl?.endRefreshing()
        fetchProductsSubject.onNext(())
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension DiscoverProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterProductsSubject.onNext(searchBar.text)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
