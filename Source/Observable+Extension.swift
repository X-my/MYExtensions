//
//  Observable+Extension.swift
//  MYExtensions
//
//  Created by xmy on 2024/4/27.
//

import RxSwift
import RxGesture

public extension ObservableType {
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
}

public extension Reactive where Base: UIView {
    func tap() -> Observable<Void> {
        return tapGesture()
            .when(.recognized)
            .mapToVoid()
    }
}
