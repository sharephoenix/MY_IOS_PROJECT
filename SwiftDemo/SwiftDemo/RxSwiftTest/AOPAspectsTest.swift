//
//  AOPAspectsTest.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/28.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Aspects

class AOPAspectsTest: NSObject {
    public class func startAop() {
        /*
         @convention
         1. 修饰 Swift 中的函数类型，调用 C 的函数时候，可以传入修饰过 @convention(c) 的函数类型，匹配 C 函数参数中的函数指针。
         2. 修饰 Swift 中的函数类型，调用 Objective-C 的方法时候，可以传入修饰过 @convention(block) 的函数类型，匹配 Objective-C 方法参数中的 block 参数
         */
        let block: @convention(block) (AnyObject?) -> Void = {
            info in
            let aspectInfo = info as! AspectInfo

            let control = aspectInfo.instance()
            //需要判类,
            if let myVc = control as? BaseViewController {
                myVc.customView()
                myVc.createUI()
                myVc.askNetwork()
            }
        }
        //block转AnyObject
        let blobj: AnyObject? = unsafeBitCast(block, to: AnyObject.self)
        do {
            let originalSelector = NSSelectorFromString("viewDidLoad")
            //在viewDidLoad之后调用
            try UIViewController.aspect_hook(originalSelector, with: .positionInstead, usingBlock: blobj)

        } catch {
            print("error = \(error)")
        }
    }

}
