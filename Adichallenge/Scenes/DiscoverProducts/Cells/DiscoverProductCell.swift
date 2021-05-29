import UIKit
import Kingfisher

final class DiscoverProductCell: UITableViewCell {
    private let placeholderImageName = "product-placeholder"

    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top
        stackView.distribution = .fill
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
        // UI setup
        return label
    }()

    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        // UI setup
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        // UI setup
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

    func setup(uiModel: DiscoverProductUIModel) {
        productImageView.kf.setImage(
            with: URL(string: uiModel.imageURL),
            placeholder: UIImage(named: placeholderImageName)
        )
        productNameLabel.text = uiModel.name
        productDescriptionLabel.text = uiModel.description
        // 👇🏼 This should be adapted based on currency position
        productPriceLabel.text = "\(uiModel.price)\(uiModel.currency)"
    }
}

private extension DiscoverProductCell {
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

        productImageView.anchor(
            widthConstant: 150,
            heightConstant: 150
        )
    }
}
