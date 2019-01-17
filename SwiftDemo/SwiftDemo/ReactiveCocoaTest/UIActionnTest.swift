//
//  UIActionnTest.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

private let instance = { () -> UIActionnTest in
   let t = UIActionnTest()
    t.load()

    return t
}()

class UIActionnTest: NSObject {
    var index: Int = 0
    public let text = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    public let loginBtn = UIButton.init(frame: CGRect.init(x: 0, y: 110, width: 100, height: 100))
    class var sharedInstance: UIActionnTest {
        return instance
    }

    func load() {
        text.backgroundColor = UIColor.red
        text.reactive.continuousTextValues.observeValues {
            text in

            print(text ?? "")
        }
        loginBtn.backgroundColor = UIColor.red
        let signal = loginBtn.reactive.controlEvents(.touchUpInside)
        signal.observeValues { btn in
            print("clicked login btn \(btn)")
        }
    }

    func actionFix() {

        text.text = "\(index + 1)"
    }
    @objc func loginAction() {
        print("loginAction")
    }
}
