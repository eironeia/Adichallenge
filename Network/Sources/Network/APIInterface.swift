import Foundation

public struct Magic {
    public init() {}
}

protocol APIInterface {
    func fetch<T: Decodable>(_ endpoint: EndpointInterface, completion: @escaping (Result<T, Error>) -> Void)
}

extension APIInterface {
    func fetch<T: Decodable>(_ endpoint: EndpointInterface, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = endpoint.urlRequest
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    preconditionFailure("No data received")
                }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
