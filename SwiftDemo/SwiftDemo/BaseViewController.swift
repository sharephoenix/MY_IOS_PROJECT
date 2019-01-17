//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/30.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    //负责对象销毁
    let disposeBag = DisposeBag()

    public func customView() {
        print(#function)
    }

    public func createUI() {
        print(#function)
    }

    public func createAction() {
        print(#function)
    }
    public func askNetwork() {
        print(#function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        createAction()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
