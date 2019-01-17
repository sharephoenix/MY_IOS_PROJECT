//
//  AOPCustomOtherTest.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/28.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
protocol AOPOtherProtocol {

}

extension AOPOtherProtocol {

    private func start(funcName: String) {
        // 内容中判定是哪个类的内容
        if Self.self == AOPCustomTest.self {
            print("test")
        } else {
            print("notest")
        }
        print(#function)
    }
    private func end () {
        print(#function)
    }
}

extension AOPOtherProtocol where Self: AOPCustomOtherTest {
    func statisticAction(funcName: String) {
        print(#function)
    }
}

extension AOPOtherProtocol where Self: AOPCustomOtherTest1 {
    func statisticAction(funcName: String) {
        print(#function)
    }
}
extension AOPOtherProtocol where Self: AOPCustomOtherTest2 {
    func statisticAction(funcName: String) {
        print(#function)
    }
}
extension AOPOtherProtocol where Self: TestController {
    func statisticAction(funcName: String) {
        print(#function)
    }
}
class AOPCustomOtherTest: AOPOtherProtocol {
    func todosomething() {
        statisticAction(funcName: #function)
    }
}
class AOPCustomOtherTest1: AOPOtherProtocol {
    func todosomething() {
        statisticAction(funcName: #function)
    }
}
class AOPCustomOtherTest2: AOPOtherProtocol {
    func todosomething() {
        statisticAction(funcName: #function)
    }
}
