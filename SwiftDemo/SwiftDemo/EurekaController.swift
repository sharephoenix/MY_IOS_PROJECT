//
//  EurekaController.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Eureka
import SnapKit
import Aspects
//
//extension Array {
//    fileprivate subscript(safe index: Int) -> Element? {
//        return indices ~= index ? self[index] : nil
//    }
//}

typealias Emoji = String
let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"

extension UIView {
    func getController() -> UIViewController? {
        var responder: UIResponder? = self.next
        var vc = responder as? UIViewController
        while vc == nil && responder != nil {
            responder = responder?.next
            vc = responder as? UIViewController
        }
        return vc
    }
}

class CustomView: UIView {

    private let button: UIButton = UIButton()

    var callBack: (() -> Void)?

    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .red
        button.backgroundColor = .yellow
        addSubview(button)
        button.layer.cornerRadius = 5
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        button.setTitle("remove", for: UIControl.State.normal)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(showController), for: UIControl.Event.touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func showController() {
        callBack?()
//        getController()?.show(EurekaController(), sender: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = self.bounds
    }
}

//@objc
class EurekaController: FormViewController {
    @objc func test() {

    }

    private let button = CustomView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eureka Case"
//        _ = try? self.aspect_hook(#selector(test), with: AspectOptions.positionBefore, usingBlock: {
//            print("123")
//        })

        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 100, width: 144, height: 44)
        button.callBack = { [weak self] in
            self?.form.remove(at: 1)
        }
        form +++ Section("Section1")
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow {
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow {
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            +++ fixHeightHeaderSection(height: 10)
            <<< EurekaCellRow { row in
                row.cell.label.text = "this is my label"
                row.cell.button.setTitle("normalclicked", for: UIControl.State.normal)
                row.cell.onGuide = { () in

                    print("this is clicked!!!")
                }
            }
            +++ fixHeightHeaderSection(height: 22)
            <<< CustomEurekaCellRow("Show Next Section0") {
                $0.cell.textLabel?.text = "aaaaaaaa"
                $0.cell.customLabel.text = "customLabel0"
                $0.value = "aaaaaa"
                $0.cell.callBack = {
                    let row: RowOf<Bool>? = self.form.rowBy(tag: "Show Next Section1")
                    row?.hidden = true
                }

            }
            <<< CustomEurekaCellRow("Show Next Section1") {
                $0.cell.textLabel?.text = "bbbbbbb"
                $0.cell.customLabel.text = "customLabel1"
            }
            <<< CustomEurekaCellRow("Show Next Section2") {
                $0.cell.textLabel?.text = "ccccccc"
                $0.cell.customLabel.text = "customLabel2"
                $0.onChange({ [weak self] (_) in
                    guard let `self` = self else { return }
                    let values: RowOf<String>? = self.form.rowBy(tag: "Show Next Section0")
                    print("\(String(describing: values?.baseValue))")
                })
            }
            <<< SwitchRow {
                $0.title = "Switch Row"
                $0.value = true
                $0.onChange({ (vvv) in
                    print("\(String(describing: vvv.value))")
                })}
            <<< SegmentedRow<String> {
                $0.options = ["111", "222", "333"]
                $0.title = "segmentTitle"
                $0.value = "4444"
                $0.onChange({ (cell) in
                    print("\(String(describing: cell.value))")
                })}
            <<< ActionSheetRow<String> {
                $0.title = "ActionSheetRow"
                $0.selectorTitle = "Your favourite player?"
                $0.options = ["111", "2222", "3333", "44444"]
                $0.onChange({ (cell) in
                    print("\(String(describing: cell.value))")
                })
                $0.value = "Luis Suarez"
                }
                .onPresent { _, to in
                    to.popoverPresentationController?.permittedArrowDirections = .left}
            <<< PushRow<Emoji> {
                $0.title = "PushRow"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = 👦🏼
                $0.onChange({ (cell) in
                    print("\(String(describing: cell.value))")
                })
                $0.onCellSelection({a, b in
                    print("selected:\(a):\(b)")
                })
                $0.selectorTitle = "Choose an Emoji!"
                }.onPresent { _, to in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
            }

        if let forrrm = form.allSections[safe: 2] {
            forrrm
                <<< PushRow<Emoji> {
                    $0.title = "Last"
                    $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                    $0.value = 👦🏼
                    $0.onChange({ (cell) in
                        print("\(String(describing: cell.value))")
                    })
                    let moreAction = SwipeAction(style: .normal, title: "More") { (_, _, completionHandler) in
                        print("More")
                        completionHandler?(true)
                    }

                    let deleteAction = SwipeAction(style: .destructive, title: "Delete", handler: { (_, _, completionHandler) in
                        print("Delete")
                        completionHandler?(true)
                    })

                    $0.trailingSwipe.actions = [deleteAction, moreAction]
                    $0.trailingSwipe.performsFirstActionWithFullSwipe = true
                    $0.selectorTitle = "Choose an Emoji!"
                    }.onPresent { _, to in
                        to.dismissOnSelection = false
                        to.dismissOnChange = false
            }
        }
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

fileprivate final class CustomEurekaCellRow: Row<CustomEurekaCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomEurekaCell>()
    }
}

private class CustomEurekaCell: Cell<String>, CellType {
    let customLabel = UILabel()
    var callBack:(() -> Void)?
    private let customButton = UIButton()
    override func setup() {
        contentView.addSubview(customLabel)
        contentView.addSubview(customButton)
        customLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(45)
        }
        customButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(33)
        }
        customButton.backgroundColor = .yellow
        customButton.addTarget(self, action: #selector(CustomEurekaCell.valueChanged), for: UIControl.Event.touchUpInside)
    }
    private var i = 0
    @objc func valueChanged() {
        i += 1
        row.value = "\(customLabel.text ?? "")::\(i)"
    }

    @objc private func willPrint() {
        print("conteText::\(customLabel.text ?? "default")")
//        self.isHidden = true
        callBack?()
    }

}

fileprivate final class EurekaCellRow: Row<EurekaCell>, RowType {

    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<EurekaCell>()
    }
}
private class EurekaCell: Cell<String>, CellType {
    public override func setup() {
        addSubview(button)
        addSubview(label)
        button.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(self.snp.leading).offset(40)
            maker.size.equalTo(CGSize.init(width: 33, height: 33))
        }
        label.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(button.snp.trailing).offset(20)
            maker.trailing.equalToSuperview()
        }

        button.addTarget(self, action: #selector(clickGuide), for: .touchUpInside)
    }

    public var onGuide: (() -> Void)?

    @objc private func clickGuide() {
        onGuide?()
    }

    let button: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 33, height: 33))
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.text = "clicked me"
        return btn
    }()

    let label: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = UIColor.yellow
        return label
    }()

}
