//
//  TestController.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
//import RxSwift
import SnapKit

class TestController: BaseViewController {

//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
    //    public var currentAdapter: MutableProperty<Test?> = MutableProperty(nil)

    var parameter: Dictionary? = [:]
    var test: ActionTest?
    var timerProxy: TimeProxy?
    var testkvo: TestKVO?
    var count: Int = 0
    public var onCollection: (() -> Void)?
    public var onBag: (() -> Void)?
    public var onGuide: (() -> Void)?

    struct OriginalPoint {
        var firstX: CGFloat
        var firstY: CGFloat
        var secondX: CGFloat
        var secondY: CGFloat
    }

    var didset: String = "" {
        didSet {
            didset += didset
            print(didset)
        }
    }
    var pagecontrol: PageControlView?
    var timer: Timer?

    var testSignal: SignalProducer<String, NoError>?
    let obj: ReactiveKVOTest? = ReactiveKVOTest()

    override func viewDidLoad() {
//        print("asdf")
        super.viewDidLoad()

        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                _ = Router.openController(className: "RouteFirstController", params: ["name": "alexluan", "address": "shanghai"])

            }
        } else {
            // Fallback on earlier versions
        }
        print("asdf")

    }

}
