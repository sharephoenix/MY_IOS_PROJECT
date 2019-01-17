//
//  PrppertyTest.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

protocol TestProtocolB {
    var id: String {get set}
    func setId(_ value: String)
    func getNickName() -> String
}

class PrppertyTest: NSObject {

    class TestClass: TestProtocolB {
        func setId(_ value: String) {
            id = value
        }

        var id: String = ""
        func getNickName() -> String {
            return "alexluan"
        }
    }
    public static func actionProtocolTest() {

        let valueProducer = MutableProperty<TestProtocolB?>(nil)
//        valueProducer.filter(initial: nil, { (observe) -> Bool in
//            return false
//        }).producer.startWithValues { (observe) in
//            print("bbbbb\(observe?.getNickName())")
//        }
//        let bb = TestClass()
//        bb.id = "00"
//        valueProducer.filter(initial: bb) { (observe) -> Bool in
//            if bb.id == "" {
//                return false
//            } else {
//                return true
//            }
//            }.producer.startWithValues { (observe) in
//                print("\(observe.id)--\(observe.getNickName())")
//        }
//        let filter = valueProducer.signal.filter { (observe) -> Bool in
//            print("bbbbb\(observe?.getNickName())")
//            return false
//        }
        valueProducer.producer.filter({ (_) -> Bool in
            return true
        }).startWithValues { (observe) in
            observe?.setId("poiur")
            print("bbbbb\(String(describing: observe?.getNickName()))")
        }
        let ccc = TestClass()
        ccc.id = "bbb"
        valueProducer.value = ccc

        print("")

    }
    public static func actionPropertyTest() {

//        let property1 = MutableProperty("0")
//        let property2 = MutableProperty("A")
//        let property3 = MutableProperty("!")
//        let property = MutableProperty(property1)
//        // Try different merge strategies and see how the results change
//        property.flatten(.latest).producer.startWithValues {(observer) in
//            print("Flattened property receive \(observer)")
//        }
//        print("Sending new value on property1: 1")
//        property1.value = "1"
//        print("Sending new value on property: property2")
//        property.value = property2
//        print("Sending new value on property1: 2")
//        property1.value = "2"
//        print("Sending new value on property2: B")
//        property2.value = "B"
//        print("Sending new value on property1: 3")
//        property1.value = "3"
//        print("Sending new value on property: property3")
//        property.value = property3
//        print("Sending new value on property3: ?")
//        property3.value = "?"
//        print("Sending new value on property2: C")
//        property2.value = "C"
//        print("Sending new value on property1: 4")
//        property1.value = "4"

        // zip propertyA:0, 1, 2
        //     propertyB:A, B, C, D
        let propertyA = MutableProperty(0)
        let propertyB = MutableProperty("A")
        let zipped = propertyA.zip(with: propertyB)
        zipped.producer.startWithValues {
            print("Zipped property received \($0)")
        }
        zipped.producer.startWithValues {_ in
            print("TTTTTT")
        }
        propertyA.value = 99
        propertyB.value = "99"
//
//        print("Setting new value for propertyA: 1")
//        propertyA.value = 1
//        print("Setting new value for propertyB: 'B'")
//        propertyB.value = "B"
//        // Observe that, in contrast to `combineLatest`, setting a new value for propertyB does not cause a new value for the zipped property until propertyA has a new value as well
//        print("Setting new value for propertyB: 'C'")
//        propertyB.value = "C"
//        print("Setting new value for propertyB: 'D'")
//        propertyB.value = "D"
//        print("Setting new value for propertyA: 2")
//        propertyA.value = 2

        //combinelatest
//        let propertyA = MutableProperty(0)
//        let propertyB = MutableProperty("A")
//        let combined = propertyA.combineLatest(with: propertyB)
//        combined.producer.startWithValues {
//            print("Combined property received \($0)")
//        }
//        print("Setting new value for propertyA: 1")
//        propertyA.value = 1
//        print("Setting new value for propertyB: 'B'")
//        propertyB.value = "B"
//        print("Setting new value for propertyB: 'C'")
//        propertyB.value = "C"
//        print("Setting new value for propertyB: 'D'")
//        propertyB.value = "D"
//        print("Setting new value for propertyA: 2")
//        propertyA.value = 2

        //unique value
//        let property = MutableProperty(0)
//        let unique = property.uniqueValues()
//        property.producer.startWithValues {
//            print("Property received \($0)")
//        }
//        unique.producer.startWithValues {
//            print("Unique values property received \($0)")
//        }
//        print("Setting new value for property: 0")
//        property.value = 0
//        print("Setting new value for property: 1")
//        property.value = 1
//        print("Setting new value for property: 1")
//        property.value = 1
//        print("Setting new value for property: 0")
//        property.value = 0
//        property.value = 320
//        property.value = 320

        //skip repeat property
//        let property = MutableProperty(0)
//        let skipRepeatsProperty = property.skipRepeats()
//        property.producer.startWithValues {
//            print("Property received \($0)")
//        }
//        skipRepeatsProperty.producer.startWithValues {
//            print("Skip-Repeats property received \($0)")
//        }
//        print("Setting new value for property: 0")
//        property.value = 0
//        print("Setting new value for property: 1")
//        property.value = 1
//        print("Setting new value for property: 1")
//        property.value = 1
//        print("Setting new value for property: 0")
//        property.value = 0

        //map
//        let property = MutableProperty(0)
//        let mapped = property.map { $0 * 2 }
//        mapped.producer.startWithValues {
//            print("Mapped property received \($0)")
//        }
//        print("Setting new value for property: 1")
//        property.value = 1
//        print("Setting new value for property: 2")
//        property.value = 2
//        print("PropertyValue:\(property.value)")

        //Binding from other Property
//        let property = MutableProperty(0)
//        property.producer.startWithValues {
//            print("Property received \($0)")
//        }
//        let otherProperty = MutableProperty(0)
//        // Notice how property receives another value of 0 as soon as the binding is established
//        property <~ otherProperty
//        print("Setting new value for otherProperty: 1")
//        otherProperty.value = 1
//        print("Setting new value for otherProperty: 2")
//        otherProperty.value = 2
//        print("properytVlaue:\(property.value)")
//        print("OtherProperytVlaue:\(property.value)")

//        let (signal, observer) = Signal<Int, NoError>.pipe()
//        let property = MutableProperty(0)
//        property.producer.startWithValues {
//            print("0Property received \($0)")
//        }
//        let property1 = MutableProperty(1)
//        property1.producer.startWithValues {
//            print("1Property received \($0)")
//        }
//        property <~ signal  // 链接管道的作用:把管道连接到属性上去
//        property1 <~ signal
//        print("Sending new value on signal: 1")
//        observer.send(value: 1)
//        print("Sending new value on signal: 2")
//        observer.send(value: 2)

//        let producer = SignalProducer<Int, NoError> { observer, lifeTime in
//            print("New subscription, starting operation")
//            observer.send(value: 9)
//            observer.send(value: 2)
//        }
//        let property = MutableProperty(0)
//        property.producer.startWithValues {
//            print("Property received \($0)")
//        }
//        // Notice how the producer will start the work as soon it is bound to the property
//        property <~ producer
    }
}
