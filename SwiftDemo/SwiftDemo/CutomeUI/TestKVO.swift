//
//  TestKVO.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class TestKVO: NSObject {
    // 加有 dynamic 标志 才有 kvo
    @objc dynamic var nickname = "alexuan"

    override init() {
        super.init()
        self.signals()
    }

    func signals() {
        self.reactive.signal(forKeyPath: "nickname").take(duringLifetimeOf: self).observeValues { (contentSize) in
            print("\(String(describing: contentSize))")
        }
    }

    func test() {
        print("nickname:\(nickname)")
    }
}
