import Foundation

public struct LocalDatabase {
    public let storage = UserDefaults.standard
    public let version = 1
    public static let shared = LocalDatabase()
    private init() {}
}

public extension LocalDatabase {
    enum KeyIdentifier: String {
        case products
    }
}
