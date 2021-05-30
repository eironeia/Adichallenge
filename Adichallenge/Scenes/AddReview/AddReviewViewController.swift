import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class AddReviewViewController: UIViewController {
    private let reviewTitle: UILabel = {
        let label = UILabel()
        label.text = "Add your review"
        label.textAlignment = .center
        return label
    }()

    private let reviewTextfield: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)

        textField.placeholder = "Write your review here"
        return textField
    }()

    private let scoreSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.value = 1
        return slider
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score value: \(Int(scoreSlider.value))"
        label.textAlignment = .center
        return label
    }()

    private let addReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add review", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        return button
    }()

    private let viewModel: AddReviewViewModelInterface
    private let addReviewButtonSubject = PublishSubject<(text: String, score: Double)>()
    private lazy var disposeBag = DisposeBag()

    init(viewModel: AddReviewViewModelInterface) {
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
    }
}

private extension AddReviewViewController {
    func setupUI() {
        view.backgroundColor = .white
        setupLayout()
    }

    func setupLayout() {
        [reviewTitle, reviewTextfield, scoreSlider, scoreLabel, addReviewButton].forEach(view.addSubview)
        reviewTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            topConstant: 32,
            leadingConstant: 8,
            trailingConstant: 8
        )

        reviewTextfield.anchor(
            top: reviewTitle.bottomAnchor,
            leading: reviewTitle.leadingAnchor,
            trailing: reviewTitle.trailingAnchor,
            topConstant: 16,
            heightConstant: 40
        )

        scoreSlider.anchor(
            top: reviewTextfield.bottomAnchor,
            leading: reviewTextfield.leadingAnchor,
            trailing: reviewTextfield.trailingAnchor,
            topConstant: 16
        )

        scoreLabel.anchor(
            top: scoreSlider.bottomAnchor,
            leading: scoreSlider.leadingAnchor,
            trailing: scoreSlider.trailingAnchor,
            topConstant: 8
        )

        addReviewButton.anchor(
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            leadingConstant: 8,
            bottomConstant: 8,
            trailingConstant: 8,
            heightConstant: 50
        )
    }

    func setupEvents() {
        let output = viewModel.transform(input: .init(addReview: addReviewButtonSubject))

        output
            .isLoading
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] isLoading in
                self?.handle(isLoading: isLoading)
            })
            .disposed(by: disposeBag)

        output
            .idle
            .asDriverOnErrorJustComplete()
            .drive()
            .disposed(by: disposeBag)
    }

    func handle(isLoading: Bool) {
        isLoading
            ? HUD.show(.progress, onView: view)
            : HUD.hide()
    }

    @objc func sliderChanged() {
        scoreSlider.value = round(scoreSlider.value)
        scoreLabel.text = "Score value: \(Int(scoreSlider.value))"
    }

    @objc func buttonTapped() {
        // TODO: Show error if field is empty
        guard let text = reviewTextfield.text else { return }
        addReviewButtonSubject.onNext((text: text, score: Double(scoreSlider.value)))
    }
}
