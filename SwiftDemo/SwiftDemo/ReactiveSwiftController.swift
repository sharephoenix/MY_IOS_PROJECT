//
//  ReactiveSwiftController.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import PinLayout

final class ReactiveSwiftController: BaseViewController {

    private let excuateButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ReactiveSwift Case"

    }

    override func createUI() {
        excuateButton.backgroundColor = .red
        view.addSubview(excuateButton)
    }

    override func createAction() {
        initCase()
        excuateButton.addTarget(self, action: #selector(racCase), for: UIControl.Event.touchUpInside)
    }

    // MARK: case 检测 方法实现
    private func initCase() {
        // 只有运行时，调用的方法才可以检测到
        self.reactive.signal(for: #selector(racCaseTest)).take(duringLifetimeOf: self).observeValues { (value) in
            print("racCase Has Excute: \(String(describing: value.first!))")
        }
    }

    @objc private func racCase() {
        print("rawAction")
        // 运行时 方法调用
        self.perform(#selector(racCaseTest), with: "luanyoushu")
        // 直接调用
        racCaseTest("testRunTimes")
    }

    @objc private func racCaseTest(_ raw: String) {
        print("racAction\(raw):\(Thread.current)")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        excuateButton.pin.top(view.pin.safeArea).marginTop(30)
        excuateButton.pin.left().margin(30)
        excuateButton.pin.width(44)
        excuateButton.pin.height(44)
    }
}
