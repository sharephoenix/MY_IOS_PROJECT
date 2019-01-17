//
//  UtilExtends.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension Array {
    subscript(safe index: Int) -> Element? {

        _ = indices ~= index ? self[index] : nil

        return indices ~= index ? self[index] : nil
    }

}

class UtilExtends: NSObject {

    public static func test() {
        let array = [1, 2, 3, 4, 5]
        let valueOfIndex = array[safe: 9]
        print(valueOfIndex ?? "")
    }

}
