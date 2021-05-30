import UIKit

final class ProductDetailsCell: UITableViewCell {
    private let placeholderImageName = "product-placeholder"
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter
    }()

    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var productImageView: UIImageView = {
        let image = UIImage(named: placeholderImageName)
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let textContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setup(uiModel: ProductDetailsUIModel) {
        productImageView.kf.setImage(
            with: URL(string: uiModel.imageURL),
            placeholder: UIImage(named: placeholderImageName)
        )
        productNameLabel.text = uiModel.name
        productDescriptionLabel.text = uiModel.description
        let number = NSNumber(value: uiModel.price)
        let formattedValue = numberFormatter.string(from: number) ?? "-"
        productPriceLabel.text = "\(formattedValue)\(uiModel.currency)"
    }
}

private extension ProductDetailsCell {
    func setupUI() {
        setupLayout()
    }

    func setupLayout() {
        contentView.addSubview(container)
        container.fillSuperview(withEdges: .init(top: 4, left: 8, bottom: 4, right: 8))
        [productImageView, textContainer].forEach(container.addArrangedSubview)
        [
            productNameLabel,
            productDescriptionLabel,
            productPriceLabel
        ].forEach(textContainer.addArrangedSubview)

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView
            .widthAnchor
            .constraint(equalTo: productImageView.heightAnchor)
            .isActive = true
    }
}
