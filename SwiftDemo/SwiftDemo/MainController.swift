//
//  MainController.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Eureka

class MainController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ fixHeightHeaderSection(height: 8)
            <<< MainEurekaCellRow("Eureka") {
                $0.onChange({ (_) in

                })
                $0.cell.customValue = "Eureka Case"
                $0.onCellSelection({ [weak self] (_, _) in
                    let vc = EurekaController()
                    self?.view.getController()?.show(vc, sender: nil)
                })}
            <<< MainEurekaCellRow("RXSwiftTableView") {
                $0.onChange({ (_) in

                })
                $0.cell.customValue = "RXSwiftTableView Case"
                $0.onCellSelection({ [weak self] (_, _) in
                    let vc = RXTableViewController()
                    self?.view.getController()?.show(vc, sender: nil)
                })}
            <<< MainEurekaCellRow("ReactiveSwift") {
                $0.onChange({ (_) in

                })
                $0.cell.customValue = "ReactiveSwift Case"
                $0.onCellSelection({ [weak self] (_, _) in
                    let vc = ReactiveSwiftController()
                    self?.view.getController()?.show(vc, sender: nil)
                })}
            <<< MainEurekaCellRow("RXViewCaseController") {
                $0.onChange({ (_) in

                })
                $0.cell.customValue = "RXViewCaseController Case"
                $0.onCellSelection({ [weak self] (_, _) in
                    let vc = RXViewCaseController()
                    self?.view.getController()?.show(vc, sender: nil)
                })}
            <<< MainEurekaCellRow("TestController") {
                $0.onChange({ (_) in

                })
                $0.cell.customValue = "TestController Case"
                $0.onCellSelection({ [weak self] (_, _) in
                    let vc = TestController()
                    self?.view.getController()?.show(vc, sender: nil)
                })}
    }

    func fixHeightHeaderSection(height: CGFloat) -> Section {
        return Section { section in
            section.header = {
                var header = HeaderFooterView<UIView>(.callback({
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    view.backgroundColor = UIColor.orange
                    return view
                }))
                header.height = { height }
                return header
            }()
        }
    }
}

fileprivate final class MainEurekaCellRow: Row<MainEurekaCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<MainEurekaCell>()
    }
}

private class MainEurekaCell: Cell<String>, CellType {
    var customValue: String? {
        set {
            customLabel.text = newValue
        }
        get { return nil }
    }
    private let customLabel = UILabel()
    var callBack:(() -> Void)?

    private let customButton = UIButton()
    override func setup() {
        contentView.addSubview(customLabel)
        contentView.addSubview(customButton)
        customLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(8)
            make.height.equalTo(22)
        }
        customButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(44)
        }
        customButton.backgroundColor = .yellow
        customButton.addTarget(self, action: #selector(MainEurekaCell.valueChanged), for: UIControl.Event.touchUpInside)
    }
    private var i = 0
    @objc func valueChanged() {
        i += 1
        row.value = "\(customLabel.text ?? "")::\(i)"
    }

    @objc private func willPrint() {
        print("conteText::\(customLabel.text ?? "default")")
        callBack?()
    }

}
