import UIKit

// TODO: Remove
import Domain
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let factory = DiscoverGymsFactory()
//
//        let viewController = factory.makeDiscoverGymsViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DiscoverProductsViewController(viewModel: DiscoverProductsViewModel(useCase: ProductsUseCase(productsProvider: ProductsProvider()))) // navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
