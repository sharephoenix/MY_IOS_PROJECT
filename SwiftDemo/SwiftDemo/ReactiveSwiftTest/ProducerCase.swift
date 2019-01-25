//
//  ProducerCase.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/25.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ProducerCase: NSObject {

    static public func case0() {
        
        let producer = SignalProducer<Int, NoError>.init { (signalObserve, lifeTime) in
            signalObserve.send(value: 1111)
        }
        // MARK: 对于简单使用的封装
//        do {
//            let disposable = CompositeDisposable()
//            let (signal, observer) = Signal<Int, NoError>.pipe(disposable: disposable)
//            observer.send(value: 111)
//            signal.observeValues { (value) in
//                print("\(value)")
//            }
//        }
        let subscriber1 = Signal<Int, NoError>.Observer.init { (signalEventValue) in
            print("\(signalEventValue)")
        }

        producer.startWithSignal { (signal, disposable) -> Void in
            signal.observe(subscriber1)
        }
    }

    static public func case1() {
        let disposable = CompositeDisposable()
        let (signal, observer) = Signal<Int, NoError>.pipe()
        observer.send(value: 9999)
        let producer = SignalProducer<Int, NoError>(signal)

        let subscriber1 = Signal<Int, NoError>.Observer.init { (signalEventValue) in
            print("\(String(describing: signalEventValue.value))")
        }

        producer.startWithSignal { (signal, disposable) -> Void in
            signal.observe(subscriber1)
        }

        observer.send(value: 1000)
        observer.send(value: 88888)
    }
}
