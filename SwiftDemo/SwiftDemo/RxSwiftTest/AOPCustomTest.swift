//
//  AOPCustomTest.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/28.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol AOPProtocol {

}

extension AOPProtocol {

    func start(funcName: String) {
        // 内容中判定是哪个类的内容
        if Self.self == AOPCustomTest.self {
            print("test")
        } else {
            print("notest")
        }
        print(#function)
    }
    func end () {
        print(#function)
    }
}

extension AOPProtocol where Self: AOPCustomTest {
    typealias ActionClousure = () -> Void
    func action(funcName: String, clousrue: ActionClousure) {
        start(funcName: #function)
        print("action")
        self.back()
        clousrue()
        end()
    }
}

class AOPCustomTest: AOPProtocol {
    func back() {
        print(#function)
    }
    func dosomething() {
        action(funcName: #function) {
            print("actionblock")
        }
    }
}

extension AOPProtocol where Self: AOPCustom {
    typealias ActionClousure0 = () -> Void

    func action(_ clousrue: ActionClousure0) {
        start(funcName: #function)
        print("action")

        clousrue()
        end()
    }
}

class AOPCustom: AOPProtocol {
    func dosomething() {
        action {
            print("this is aopCustom")
        }
    }

}
