//
//  AsynAndThreadTest.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class AsynAndThreadTest: NSObject {
    public static func testThreadAndAsyn(backblock: (_ group: DispatchGroup) -> Void) {
        let queue = DispatchQueue.init(label: "gcdtest.rongfzh.yc")
        let group = DispatchGroup.init()
        group.enter()
        queue.async (group: group) {
            print("doing stuff again:\(Thread.current)")
            group.leave()
        }

        group.enter()
        queue.async (group: group) {
            print("doing more stuff again :\(Thread.current)")
//            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            print("done doing stuff again:\(Thread.current)")
        }

//        backblock(group)

        print("this is end:\(Thread.current)")

        queue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            print("lastLeave:\(Thread.current)")
            group.leave()
        }

    }
}
