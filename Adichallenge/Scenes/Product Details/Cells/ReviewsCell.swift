import UIKit

final class ReviewsCell: UITableViewCell {
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top
        return stackView
    }()

    private let reviewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // UI setup
        return label
    }()

    private let reviewScoreLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        // UI setup
        return label
    }()

    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setup(uiModel: ReviewUIModel) {
        reviewDescriptionLabel.text = uiModel.text
        let number = NSNumber(value: uiModel.rating)
        let formattedValue = numberFormatter.string(from: number) ?? "-"
        reviewScoreLabel.text = "\(formattedValue)⭐️"
    }
}

private extension ReviewsCell {
    func setupUI() {
        setupLayout()
    }

    func setupLayout() {
        contentView.addSubview(container)
        container.fillSuperview(withEdges: .init(top: 8, left: 8, bottom: 8, right: 8))
        [reviewDescriptionLabel, reviewScoreLabel].forEach(container.addArrangedSubview)
    }
}
