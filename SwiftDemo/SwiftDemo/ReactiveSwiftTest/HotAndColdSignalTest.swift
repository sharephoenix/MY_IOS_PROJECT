//
//  HotAndColdSignalTest.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
//import RxSwift

class HotAndColdSignalTest: NSObject {

    public static func actionCreateCold2SignalMethods() {

//        SignalProducer<Int, NoError>([ 1, 2, 3, 4 ])
//            .combinePrevious(42)
//            .startWithValues { value in
//                print("\(value)")
//        }

//        SignalProducer<Int, NoError>([ 1, 2, 3, 4 ])
//            .scan(0, +)
//            .startWithValues { value in
//                print(value)
//        }

//        SignalProducer<Int, NoError>([ 1, 2, 3, 4, 9 ])
//            .reduce(0, +)
//            .startWithValues { value in
//                print(value)
//        }

//        SignalProducer<Int, NoError>([ 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 1, 1, 1, 2, 2, 2, 4 ])
//            .skipRepeats(==)
//            .startWithValues { value in
//                print(value)
//        }

//        SignalProducer<Int, NoError>([ 3, 3, 3, 3, 1, 2, 3, 4 ])
//            .skip { (value)->Bool in
//                //跳过 value > 2 ，返回false 以后，开始返回
//                return value > 2
//            }
//            .startWithValues { value in
//                print(value)
//        }

//        SignalProducer<Int, NoError>([ 1, 2, 3, 4 ])
//            .take(last: 3)
//            .startWithValues { value in
//                print(value)
//        }

//        SignalProducer<Int?, NoError>([ nil, 1, 2, nil, 3, 4, nil ])
//            .skipNil()
//            .startWithValues { value in
//                print(value)
//        }

        let baseProducer = SignalProducer<Int, NoError>([ 1, 2, 3, 4 ])
        let zippedProducer = SignalProducer<Int, NoError>([ 42, 43, 100, 120, 110])
        baseProducer
            .zip(with: zippedProducer)
            .startWithValues { value in
                print("\(value.1)")
        }

//        var counter = 0
//        SignalProducer<(), NoError> { observer, disposable in
//            counter += 1
//            observer.sendCompleted()
//            }
//            .repeat(42)
//            .start()
//        print(counter)

//        var tries = -10
//        SignalProducer<Int, NSError> { observer, disposable in
//            if tries < 2 {
//                tries += 1
//                observer.send(error: NSError(domain: "retry", code: 0, userInfo: nil))
//            } else {
//                observer.send(value: tries)
//                observer.sendCompleted()
//            }
//            }
//            .retry(upTo: 15)
//            .startWithResult { result in
//                print("tries:\(String(describing: result.value))")
//        }

//        let baseProducer = SignalProducer<Int, NoError>([ 1, 2, 3, 4 ])
//        let thenProducer = SignalProducer<Int, NoError>(value: 42)
//        baseProducer
//            .then(thenProducer)
//            .startWithValues { value in
//                print(value)
//        }

//        let baseProducer = SignalProducer<Int, NoError>([ 1, 2, 3, 4, 42 ])
//            .replayLazily(upTo: 2)
//        baseProducer.startWithValues { value in
//            print("1:\(value)")
//        }
//        baseProducer.startWithValues { value in
//            print("2:\(value)")
//        }
//        baseProducer.startWithValues { value in
//            print("3:\(value)")
//        }

//        SignalProducer<Int, NoError>([ 1, 2, 3, 4 ])
//            .flatMap(.latest) { SignalProducer(value: $0 + 3) }
//            .startWithValues { value in
//                print(value)
//        }

//        SignalProducer<Int, NSError>(error: NSError(domain: "flatMapError", code: 42, userInfo: nil))
//            .flatMapError { SignalProducer<Int, NoError>(value: $0.code) }
//            .startWithValues { value in
//                print(value)
//        }

//        let producer = SignalProducer<Int, NoError>([ 1, 2 ])
//        let sampler = SignalProducer<String, NoError>([ "a", "b", "c" ])
//        let result = producer.sample(with: sampler)
//        result.startWithValues { left, right in
//            print("\(left) \(right)")
//        }

//        let baseProducer = SignalProducer<Int, NoError>([ 1, 2, 3, 4, 42 ])
//        baseProducer
//            .logEvents(identifier: "Playground is fun!")
//            .start()

//        var started = false
//        var value: Int?
//
//        SignalProducer<Int, NoError>(value: 42)
//            .on(value: {
//                value = $0
//            })
//            .startWithSignal { signal, disposable in
//                print(value)
//        }
//
//        print(value)

    }

    public static func actionCreateCold1SignalMethods() {
//        A producer for a Signal that never sends any events to its observers.
        let emptyProducer = SignalProducer<Int, NoError>.empty

        let observer = Signal<Int, NoError>.Observer(
            value: { _ in print("value not called") },
            failed: { _ in print("error not called") },
            completed: { print("completed called") }
        )
        emptyProducer.start(observer)

    }

    public static func actionCreateCold0SignalMethods() {

//        传说中的冷信号
        let producer = SignalProducer<Int, NoError> { observer, _ in
            print("New subscription, starting operation")
            observer.send(value: 1)
            observer.send(value: 2)
        }

        let subscriber1 = Signal<Int, NoError>.Observer(value: {
            print("Subscriber 1 received \($0)")

        })
        let subscriber2 = Signal<Int, NoError>.Observer(value: {
            print("Subscriber 2 received \($0)")

        })

        print("Subscriber 1 subscribes to producer")
        producer.start(subscriber1)

        print("Subscriber 2 subscribes to producer")
        // Notice, how the producer will start the work again
        producer.start(subscriber2)
    }

}
