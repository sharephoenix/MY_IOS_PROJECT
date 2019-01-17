//
//  LoginViewModel.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/12/7.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class LoginViewModel: NSObject {

    var userNameSignal: Signal<String?, NoError>//接收用户名的信号
    var passWordSignal: Signal<String?, NoError>//接收密码的信号
    var validSignal: Signal<Bool, NoError>//用户名和密码是否合法的信号
    var loginAction: Action<(String, String), Bool, NoError>//登录的action

    var tttText: UITextField = UITextField()

    init(_ signal1: Signal<String?, NoError>, _ signal2: Signal<String?, NoError>) {

        let _: Signal<String?, NoError> = tttText.reactive.textValues
        //获取用户名输入框和密码输入框文字变化的信号
        userNameSignal = signal1
        passWordSignal = signal2

        //合并信号
        validSignal = Signal.combineLatest(userNameSignal, passWordSignal).map { $0!.count >= 5 && $1!.count >= 6}

        //根据合并的信号，创建控制登录按钮enable的属性
        let loginEnable = Property(initial: false, then: validSignal)

        //通过.map对输入框变化的信号进行映射
        let colorSignal: Signal<UIColor, NoError> = signal1.map { text in
            return (text?.count)! > 3 ? .white : .red
        }
        //根据信号创建textfield的颜色属性
        _ = Property(initial: .white, then: colorSignal)

        loginAction = Action(enabledIf: loginEnable) {
            username, password in

            return SignalProducer<Bool, NoError> { observer, _ in
                let success = (username == "admin") && (password == "password")
                //网络请求
                observer.send(value: success)
                observer.sendCompleted()
            }
        }

    }

}
