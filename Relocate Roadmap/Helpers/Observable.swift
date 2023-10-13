//
//  Observer.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 13.10.2023.
//

import Foundation

class Observable<T> {

    typealias Listener = ((T?) -> Void)

    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }

   private var listener: Listener?

    init(_ value: T?) {
        self.value = value
    }

    func bind(_ listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
