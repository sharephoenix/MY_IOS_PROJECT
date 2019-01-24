//
//  WeexVueController.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/18.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
//方法1 pod依赖方式
import WeexSDK
import TBWXDevTool

class WeexVueController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "单独写了一个demo"
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRefreshInstance), name: NSNotification.Name(rawValue: "RefreshInstance"), object: nil)
//        WXDevTool.setDebug(true)
//
//        WXDevTool.launchDebug(withUrl: "ws://192.168.2.151:8888/debugProxy/nativ")
    }

    @objc func notificationRefreshInstance() {

    }

    private func render() {

    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
