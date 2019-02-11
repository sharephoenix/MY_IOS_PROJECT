//
//  Queue01.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/28.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Foundation

class Queue01: NSObject {

    private var writeQueue = DispatchQueue(label: "com.xhb.VideoWriteQueue")
    private var count: Int = 0

    public func case0() {
        for i in 0..<100 {
            writeQueue.async {
                self.count += 1
                sleep(1)
                print("print: \(i)")
            }
        }
        for i in 100..<150 {
            writeQueue.async {
                self.count += 1
                sleep(1)
                print("print: \(i)")
            }
        }

        print("time over")
    }

}
