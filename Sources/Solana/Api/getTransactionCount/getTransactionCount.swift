import Foundation

public extension Api {
    func getTransactionCount(commitment: Commitment? = nil, onComplete: @escaping (Result<UInt64, Error>) -> Void) {
        router.request(parameters: [RequestConfiguration(commitment: commitment)]) { (result: Result<UInt64, Error>) in
            switch result {
            case .success(let count):
                onComplete(.success(count))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}

public extension ApiTemplates {
    struct GetTransactionCount: ApiTemplate {
        public init(commitment: Commitment? = nil) {
            self.commitment = commitment
        }

        public let commitment: Commitment?

        public typealias Success = UInt64

        public func perform(withConfigurationFrom apiClass: Api, completion: @escaping (Result<Success, Error>) -> Void) {
            apiClass.getTransactionCount(commitment: commitment, onComplete: completion)
        }
    }
}
