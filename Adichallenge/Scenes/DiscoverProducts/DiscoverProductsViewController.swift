import UIKit
import RxSwift

final class DiscoverProductsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        let obsevable = PublishSubject<Void>()
    }
}

