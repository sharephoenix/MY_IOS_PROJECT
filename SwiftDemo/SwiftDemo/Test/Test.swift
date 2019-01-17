//
//  Test.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/30.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

// runtime 给动态类赋值
protocol TestProtocol {
    func actionProtocol(address: String)
}
var testname = 123
var myNameKey = 100
var myAgeKey = 101
var myOptionKey = 102

extension Test {
    var myName: String {
        set {
            objc_setAssociatedObject(self, &myNameKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        get {
            if let rs = objc_getAssociatedObject(self, &myNameKey) as? String {
                return rs
            }
            return ""
        }
    }

    var nickname: String? {
        set {
            objc_setAssociatedObject(self, &testname, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let nickname = objc_getAssociatedObject(self, &testname) as? String {
                return nickname
            } else {
                return nil
            }
        }
    }

    func exFunction() {
        print("asdf")
    }
}

open class Test: NSObject, TestProtocol {
    @objc open func actionProtocol(address: String) {

    }

    @objc open func actiontest(name: String) {

        self.responds(to: #selector(actionProtocol(address:)))
    }
}

extension Test {
    func actionTest() {
        let test0 = Test()
        let test1 = Test()
        test0.nickname = "alexluan"
        test1.nickname = "ericluan"
        test0.nickname = nil
        print("adsf\(String(describing: test0.nickname))---\(String(describing: test1.nickname))")
    }
}
