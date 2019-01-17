//
//  RXViewCase.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import PinLayout
import RxSwift
import RxCocoa
import Result

class RXViewCase: UIView {

    static let allHeight: CGFloat = 152 + 40 + 60

    private let disposeBag = DisposeBag()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "result label"
        return label
    }()

    private let userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter user name please"
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter pass word please"
        return textField
    }()

    private let loginButton: UIButton = UIButton()

    private var pickView: UIPickerView = UIPickerView()

    @objc private var backColor: UIColor = .red

    init() {
        super.init(frame: CGRect.zero)
        createUI()
        createAction()
    }

    private func createUI() {
        backgroundColor = backColor
        resultLabel.backgroundColor = .groupTableViewBackground
        resultLabel.numberOfLines = 0
        userTextField.backgroundColor = .groupTableViewBackground
        passwordTextField.backgroundColor = .groupTableViewBackground
        loginButton.backgroundColor = .black
        loginButton.setTitle("enable", for: UIControl.State.normal)
        loginButton.setTitle("unEnable", for: UIControl.State.disabled)
        loginButton.layer.cornerRadius = 4
        pickView.backgroundColor = .white
        addSubview(resultLabel)
        addSubview(userTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(pickView)
    }

    private func createAction() {
        _ = userTextField.rx.text.subscribe(onNext: { [weak self] (content) in
            self?.resultLabel.text = content
        }, onError: { (error) in
            print("error")
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })

        let validateUserName = userTextField.rx.text.orEmpty.map { (content) -> Bool in
            return content.count > 5
        }
        let validatePassWord = passwordTextField.rx.text.orEmpty.map { (content) -> Bool in
            return content.count > 5
        }
        let allValidate = Observable.combineLatest(validateUserName, validatePassWord).map { (arg0) -> Bool in
            let (username, password) = arg0
            return username && password
        }
        _ = allValidate.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)

        _ = loginButton.rx.tap.subscribe(onNext: { [weak self] in
            print("loginButtonAction!!!!")
            self?.showAlert()
        }).disposed(by: disposeBag)

        do {
            Observable.just([UIColor.red, UIColor.green, UIColor.blue])
                .bind(to: pickView.rx.items) { _, item, _ in
                    let view = UIView()
                    view.backgroundColor = item
                    return view
                }
                .disposed(by: disposeBag)

            _ = pickView.rx.modelSelected(UIColor.self).subscribe(onNext: { [weak self] (models) in
                print("models selected 3: \(models)")
                self?.backgroundColor = models[0]
            }).disposed(by: disposeBag)
        }

//        do { // pickView other styles
//            Observable.just([1,2,3]).bind(to: pickView.rx.itemTitles) { _, item in
//                return "\(item)::::"
//                }
//                .disposed(by: disposeBag)
//
//            _ = pickView.rx.modelSelected(Int.self).subscribe(onNext: { models in
//                print("selected::\(models)")
//            }).disposed(by: disposeBag)
//
//        }
        
    }

    deinit {
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showAlert() {
        let alerViewController = UIAlertController.init(title: "RxExample", message: "this is wonderful", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction.init(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alerViewController.addAction(cancelAction)
        self.getController()?.present(alerViewController, animated: true, completion: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let hOffset: CGFloat = 100
        resultLabel.text = "\(self.bounds)"
        resultLabel.pin.top().marginTop(10)
        resultLabel.pin.height(33)
        resultLabel.pin.width(100%)
        userTextField.pin.below(of: resultLabel).marginTop(10)
        userTextField.pin.left(pin.safeArea).right(pin.safeArea).margin(0)
        userTextField.pin.width(bounds.width / 2.0 - 4 - hOffset)
        userTextField.pin.height(44)

        passwordTextField.pin.after(of: userTextField, aligned: .center).marginLeft(8)
        passwordTextField.pin.height(44)
        passwordTextField.pin.width(bounds.width / 2.0 - 4 + hOffset)

        loginButton.pin.below(of: [userTextField, passwordTextField], aligned: .center).marginTop(8)//.below(of: userTextField, aligned: .center).marginTop(8)
        loginButton.pin.width(50%)
        loginButton.pin.height(44)

        pickView.pin.below(of: loginButton, aligned: .center).marginTop(8)
        pickView.pin.width(50%)
        pickView.pin.height(92)

    }
}
