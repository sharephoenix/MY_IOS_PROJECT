//
//  SignalTest.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class SignalTest: NSObject {
    public static func actionSignalTest() {

        //TODO: 这里没有太明白 empty signal 是用来做什么的，
//        let emptySignal = Signal<Int, NoError>.empty
//        let notEmptySignal = Signal<Int,NoError>.Observer(value: { (value) in
//            print("this is not empty value: \(value)")
//        })
//        let observer = Signal<Int, NoError>.Observer(
//            value: { (value) in print("value not called:\(value)") },
//            failed: { _ in print("error not called") },
//            completed: { print("completed not called") },
//            interrupted: { print("interrupted called") }
//        )
//        emptySignal.observe(observer)
//        emptySignal.observe(notEmptySignal)
//        observer.send(value: 99)
//        observer.send(value: 100)
//        observer.sendCompleted()
//        observer.send(value: 119)

        // Signal.pipe is a way to manually control a signal. the returned observer can be used to send values to the signal
        let (signal, observer) = Signal<Int, NoError>.pipe()
        let subscriber1 = Signal<Int, NoError>.Observer(value: { print("Subscriber 1 received \($0)") })
        let subscriber2 = Signal<Int, NoError>.Observer(value: { print("Subscriber 2 received \($0)") })
        print("Subscriber 1 subscribes to the signal================")
        signal.observe(subscriber1)
        print("Send value `10` on the signal")
        // subscriber1 will receive the value
        observer.send(value: 10)
        print("Subscriber 2 subscribes to the signal=================")
        // Notice how nothing happens at this moment, i.e. subscriber2 does not receive the previously sent value
        signal.observe(subscriber2)
        print("Send value `20` on the signal")
        // Notice that now, subscriber1 and subscriber2 will receive the value
        observer.send(value: 20)
    }
}
