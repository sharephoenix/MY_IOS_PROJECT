//
//  RXViewCaseController.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import PinLayout
import RxSwift

class RXViewCaseController: BaseViewController {
    private var viewCase: RXViewCase? = RXSwiftMainCase.rxViewCase()

    private var disposeButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RXSwift Bind And Button"
    }

    override func createUI() {
        viewCase!.backgroundColor = .red
        disposeButton.backgroundColor = .blue
        disposeButton.setTitle("dispose", for: .normal)
        view.addSubview(viewCase!)
        view.addSubview(disposeButton)
    }

    override func createAction() {
        disposeButton.rx.tap.subscribe(onNext: { [weak self] (sender) in
            self?.viewCase?.removeFromSuperview()
            self?.viewCase = nil
        }).disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let viewCase = viewCase {
            viewCase.pin.left(view.pin.safeArea).top(view.pin.safeArea).right(view.pin.safeArea).margin(0)
            viewCase.pin.height(RXViewCase.allHeight)
            disposeButton.pin.left(view.pin.safeArea).right(view.pin.safeArea).margin(0)
            disposeButton.pin.below(of: viewCase).marginTop(8)
            disposeButton.pin.height(44)
        } else {
            disposeButton.pin.left(view.pin.safeArea).right(view.pin.safeArea).margin(0)
            disposeButton.pin.top(view.pin.safeArea).marginTop(8)
            disposeButton.pin.height(44)
        }
    }
}
