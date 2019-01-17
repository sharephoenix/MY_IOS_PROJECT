//
//  RouteFirstController.swift
//  SwiftDemo
//
//  Created by Alexluan on 2018/11/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class RouteFirstController: LBaseController {

    var dic: Dictionary<String, Any?>?

    convenience required init(params: Dictionary<String, Any?>) {
        self.init()
        print(params)
        self.dic = params
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        print("asdf")
    }

}
