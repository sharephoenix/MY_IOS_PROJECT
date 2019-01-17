//
//  ReactiveKVOTest.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/30.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class ReactiveKVOTest: NSObject {

    @objc dynamic var nickname: String? = "name"

    let (signalA, observerA) = Signal<String, NoError>.pipe()
    let (signalB, observerB) = Signal<String, NoError>.pipe()
    var validSignal: Signal<String, NoError>?
    let a = MutableProperty<String>("mmmm")
    private var requestImageSizeDisposable: Disposable?

    func actionCold() {
        a.signal.observeValues { (value) in
            print("\(value)")
        }
        print(a.value)
        a.value = "asdfasdf"
        a.value = "12312312312"
        //=========================================================================//
        // 1.通过信号发生器创建(冷信号)
//        let producer = SignalProducer<String, NoError>.init { (observer, _) in
//            print("新的订阅，启动操作")
//            observer.send(value: "Hello")
//            observer.send(value: "World")
//        }
//
//
//        let subscriber1 = Observer<String, NoError>(value: {
//            print("观察者1接收到值 \($0)")
//
//        })
//        let subscriber2 = Observer<String, NoError>(value: {
//            print("观察者2接收到值 \($0)")
//
//        })
//
//        print("观察者1订阅信号发生器")
//        producer.start(subscriber1)
//        print("观察者2订阅信号发生器")
//        producer.start(subscriber2)
    }
    func actionTestHot() {
        // 2.通过管道创建（热信号）x
        self.reactive.producer(forKeyPath: "nickname").start({(react) in
            print(react)
        })
//        self.reactive.values(forKeyPath: "nickname").start { (react) in
//            print(react)
//        }
//        Signal.combineLatest(signalA,signalB).observeValues({ (react) in
//            print("asdf")
//        })

        signalA.observeValues { (value) in
            print(value)
        }

//            Signal.combineLatest(signalA, signalB).observeValues { (value) in
//            print( "收到的值\(value.0) + \(value.1)")
//            }
        observerA.send(value: "1")
        observerB.send(value: "1")
    }
}
