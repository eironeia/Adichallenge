import UIKit

// TODO: Remove
import Domain
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()

        let coordinator = DiscoverProductsCoordinator(
            presenter: navigationController,
            scenesFactory: DiscoverProductsFactory()
        )

        coordinator.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
