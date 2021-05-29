import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class ProductDetailsViewController: UITableViewController {
    private var sectionsType: [ProductDetailsViewModel.Section] = []
    private let viewModel: ProductDetailsViewModelInterface
    private let showProductSubject = PublishSubject<Void>()
    private lazy var disposeBag = DisposeBag()

    init(viewModel: ProductDetailsViewModelInterface) {
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
        showProductSubject.onNext(())
    }
}

private extension ProductDetailsViewController {
    func setupUI() {
        title = "Product details"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = false
        tableView.allowsSelection = false
        tableView.register(
            ProductDetailsCell.self,
            forCellReuseIdentifier: ProductDetailsCell.identifier
        )
        tableView.register(
            ReviewsCell.self,
            forCellReuseIdentifier: ReviewsCell.identifier
        )
    }

    func setupEvents() {
        let output = viewModel.transform(input: .init(showProduct: showProductSubject))

        output
            .sections
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] sections in
                self?.sectionsType = sections
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    func handle(isLoading: Bool) {
        isLoading
            ? HUD.show(.progress, onView: view)
            : HUD.hide()
    }
}

// MARK: - Datasource

extension ProductDetailsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsType.count
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch sectionsType[section] {
        case .details: return 1
        case let .reviews(reviews): return reviews.count
        }
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch sectionsType[indexPath.section] {
        case let .details(uiModel):
            let cell = tableView.cell(as: ProductDetailsCell.self)
            cell.setup(uiModel: uiModel)
            return cell
        case let .reviews(reviews):
            let uiModel = reviews[indexPath.row]
            let cell = tableView.cell(as: ReviewsCell.self)
            cell.setup(uiModel: uiModel)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sectionsType[section] {
        case .details: return nil
        case .reviews: return "Reviews"
        }
    }
}

// MARK: - Delegate

extension ProductDetailsViewController {}
