//
//  ActionTest.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ActionTest: NSObject {
    var parentView: UIView
    var usernameTextField: UITextField! = UITextField.init()
    var passwordTextField: UITextField! = UITextField.init()
    var signInBtn = UIButton()

    var changeAction: Action<(String, String), Bool, NoError>?
    var validSignal: Signal<Bool, NoError>?
    var changeEnable: Property<Bool>?

    var testBtn: UIButton = UIButton.init()

    init(parentView: UIView) {
        self.parentView = parentView

    }

    func loadAll() {
        loadUI()
        loadData()
        loadAction()
    }

    /// 初始化 UI
    private func loadUI() {
        parentView.addSubview(signInBtn)
        parentView.addSubview(usernameTextField)
        usernameTextField.backgroundColor = UIColor.lightGray
        parentView.addSubview(passwordTextField)
        passwordTextField.backgroundColor = UIColor.lightGray
        signInBtn.backgroundColor = UIColor.yellow
        signInBtn.snp.makeConstraints { (make) in
            make.center.equalTo(parentView)
            make.size.equalTo(CGSize.init(width: 33, height: 33))
        }
        usernameTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(parentView)
            make.top.equalTo(parentView.snp.top).offset(100)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(parentView)
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }

    }

    /// 初始化数据
    private func loadData() {

        validSignal = Signal.combineLatest(usernameTextField.reactive.continuousTextValues, passwordTextField.reactive.continuousTextValues).map({ a, b -> Bool in
            print("a:\(String(describing: a)),b:\(String(describing: b))")
            if a == b {
                return true
            } else {
                return false
            }

        })

        if let signal = validSignal {
            changeEnable = Property(initial: true, then: signal)
            signal.producer.on().startWithResult { (result) in
                if result.value == true {
                    self.signInBtn.backgroundColor = UIColor.yellow
                } else {
                    self.signInBtn.backgroundColor = UIColor.lightGray
                }
            }
        }

        if let enable = changeEnable {
            changeAction = Action(enabledIf: enable, execute: { (oldPd, newPD) in

                SignalProducer<Bool, NoError> { observer, _ in
                    // 里面可以处理网络请求
                    if oldPd == newPD {
                        observer.send(value: true)
                    } else {
                        observer.send(value: false)
                    }
                    observer.sendCompleted() // 必须执行才能接受下次的点击事件，可以避免按钮的重复点击
                }
                
            })

        }
        changeAction?.values.producer.on().startWithResult { [weak self] value in
            guard self != nil else {
                return
            }
            if let result = value.value, result {
                print("testSuccessAction")

            } else {
                print("testErrorAction")
            }
        }

    }
    /// 初始化时间
    private func loadAction() {
        if let action = changeAction {

            signInBtn.reactive.pressed = CocoaAction(action, { _ in
                return (self.usernameTextField.text ?? "", self.passwordTextField.text ?? "")
            })
        }

        testBtn.reactive.controlEvents(.touchUpInside).observeValues { (_) in
            print("it is clicked!!!")
        }

    }
    /// Test
    func actionTest() {

    }
}
