// swiftlint:disable line_length
//  Source: https://github.com/sergdort/CleanArchitectureRxSwift/blob/master/CleanArchitectureRxSwift/Utility/Observable%2BExt.swift

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType where Element == Bool {
    /// Boolean not operator
    func not() -> Observable<Bool> {
        map(!)
    }
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        map { _ in }
    }
}

extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { _ in
            Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }

    func startLoading(loadingSubject: PublishSubject<Bool>) -> Observable<Element> {
        self
            .do(onNext: { _ in loadingSubject.onNext(true) })
    }

    func stopLoading(loadingSubject: PublishSubject<Bool>) -> Observable<Element> {
        self
            .do(onNext: { _ in loadingSubject.onNext(false) },
                onError: { _ in loadingSubject.onNext(false) })
    }
}

extension ObservableType {
    static func createFromResultCallback<E: Error>(_ fn: @escaping (@escaping (Result<Element, E>) -> Void) -> Void) -> Observable<Element> {
        return Observable.create { observer in
            fn { result in
                switch result {
                case let .success(value):
                    observer.onNext(value)
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
