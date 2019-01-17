//
//  CommentUtils.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class TimeProxy {
    var timer: Timer!
    var timerHandler:(() -> Void)?
    var timerHandler0: ((String?, String?) -> String?)?
    init(withInterval interval: TimeInterval, repeats: Bool, timerHandler: (() -> Void)?) {
        self.timerHandler = timerHandler
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(timerDidFire),
                                     userInfo: nil,
                                     repeats: repeats)
    }
    init(withInterval interval: TimeInterval, repeats: Bool, timerHandler: ((String?, String?) -> String?)?) {
        self.timerHandler0 = timerHandler
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(timerDidFire0),
                                     userInfo: nil,
                                     repeats: repeats)
    }

    @objc func timerDidFire() {
        timerHandler?()
    }
    @objc func timerDidFire0() {
       let nickname = timerHandler0?("name", "alexuan")
        print("this is nickname:\(nickname ?? "defaultname")")
    }
    func invalidate() {
        timer.invalidate()
    }

}
class CommentUtils: NSObject {

}
