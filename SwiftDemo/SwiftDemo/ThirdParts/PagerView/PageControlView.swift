//
//  PageControlView.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class PageControlView: UIView {

    enum Direction {
        case center
    }

    private var backView: UIView = UIView()

    var numberOfPages: Int = 0 {
        didSet {
            self.creatAllDot(count: numberOfPages)
        }
    }
    var selectedIndex: Int? = nil {
        didSet {
            selectedIndex != nil ? fixDotStyle(selectedIndex: selectedIndex!) : ()
            self.layoutSubviews()
            if let selectedIndex = selectedIndex {
                self.callBackSelected?(selectedIndex)
            }
        }
    }
    var callBackSelected:((_ selectedIndex: Int)->Void)?
    var position: Direction = .center

    private var gapSpace: Float = 5

    var normalStyle = PageDotStyle()
    var selectedStyle = PageDotStyle()

    var dotArray: [PageDot] = []

    private func fixDotStyle(selectedIndex: Int) {
        for index in 0..<dotArray.count {
            let pageDot = dotArray[index]
            selectedIndex == index ? {
                pageDot.currentState = .selected
                }() : {
                    pageDot.currentState = .normal
                }()

        }
    }

    private func creatAllDot(count: Int) {
        dotArray.removeAll()
        for _ in 0..<count {
            let pageDot = PageDot()
            pageDot.selectedStyle = selectedStyle
            pageDot.normalStyle = normalStyle
            dotArray.append(pageDot)
            backView.addSubview(pageDot)
        }
        backView.backgroundColor = UIColor.red
        addSubview(backView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frame = self.bounds
        var needX: Float = gapSpace
        for index in 0..<dotArray.count {
            let item = dotArray[index]
            item.center = backView.center
            item.pointX = needX
            needX += Float(item.frame.width)
            needX += gapSpace
        }
        backView.frame.size = CGSize.init(width: CGFloat(needX), height: backView.frame.size.height)
        backView.center = self.getSelfCenter()

    }

}

extension UIView {
    func getSelfCenter() -> CGPoint {
        let x = self.frame.width / 2.0
        let y = self.frame.height / 2.0
        return CGPoint.init(x: x, y: y)
    }
}

enum PageDotShap {
    case circle
    case ellipse
}
enum PageDotStatus {
    case normal
    case selected
}

struct PageDotStyle {
    var shapType: PageDotShap = .circle
    var showColor: UIColor = UIColor.white
    var currentImage: UIImage? = UIImage.init(named: "ic_my_about_arrow")
    var showSize: CGSize = CGSize(width: 10, height: 10)
}

class PageDot: UIButton {

    var currentState: PageDotStatus = .normal {
        didSet {
            currentState == .normal ? {
                self.isSelected = false

                }() : {self.isSelected = true}()
            self.layoutSubviews()
        }
    }

    var normalStyle = PageDotStyle() {
        didSet {
            self.setImage(normalStyle.currentImage, for: .normal)
        }
    }
    var selectedStyle = PageDotStyle() {
        didSet {
            self.setImage(selectedStyle.currentImage, for: .selected)
        }
    }

    var pointX: Float = 0 {
        didSet {
            var frame = self.frame
            frame.origin.x = CGFloat(pointX)
            frame.size = self.currentState == .normal ? normalStyle.showSize : selectedStyle.showSize
            self.layer.cornerRadius = frame.size.height / 2.0
            self.frame = frame
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = currentState == .normal ? {normalStyle.showColor}() : {selectedStyle.showColor}()
    }

}
