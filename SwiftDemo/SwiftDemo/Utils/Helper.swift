//
//  Helper.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class Helper: NSObject {

    class func getCurrentWindow() -> UIWindow? {
        let window = UIApplication.shared.keyWindow
        return window
    }

    class func getCurrentNavController() -> UIViewController? {
        guard let window = Helper.getCurrentWindow() else {
            return nil
        }
        var vc = window.rootViewController
        while vc != nil {
            if let tabVC = vc as? UITabBarController {
                vc = tabVC.selectedViewController
                continue
            } else if let navVC = vc as? UINavigationController {
                vc = navVC.topViewController
                return vc
            } else {
                break
            }
        }
        return  vc
    }

    class func viewController(view: UIView) -> UIViewController? {
        var next: UIResponder?
        next = view.next!
        repeat {
            if ((next as?UIViewController) != nil) {
                return (next as! UIViewController)
            } else {
                next = next?.next
            }
        } while next != nil
        return nil
    }
    class func viewWindow(view: UIView) -> UIWindow? {
        var next: UIResponder?
        next = view.next!
        repeat {
            if ((next as? UIWindow) != nil) {
                return (next as! UIWindow)
            } else {
                next = next?.next
            }
        } while next != nil
        return nil
    }
}
