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
        reviewScoreLabel.text = "\(uiModel.rating)"
    }
}

private extension ReviewsCell {
    func setupUI() {
        setupLayout()
    }

    func setupLayout() {
        contentView.addSubview(container)
        container.fillSuperview(withEdges: .init(top: 4, left: 8, bottom: 4, right: 8))
        [reviewDescriptionLabel, reviewScoreLabel].forEach(container.addArrangedSubview)
    }
}
