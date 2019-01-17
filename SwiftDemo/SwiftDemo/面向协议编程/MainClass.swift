//
//  MainClass.swift
//  SwiftDemo
//
//  Created by Alexluan on 2018/11/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

public protocol TcpProtocol {
//    typealias <#type name#> = <#type expression#>
//    associatedtype Item: Dictionary<String,Any>
    init(no1: Dictionary<String, Any>)
}

public class MainClass {
    var no1: Int // local storage

    init(no1: Int) {
        self.no1 = no1 // initialization
    }
}

class SubClass: MainClass, TcpProtocol {
    var objDic: Dictionary<String, Any>?
    required convenience init(no1: Dictionary<String, Any>) {
        self.init(no1: 2, no2: 4)
        self.objDic = no1
        print(no1)
    }

    var no2: Int
    init(no1: Int, no2: Int) {
        self.no2 = no2
        super.init(no1: no1)
    }

}
