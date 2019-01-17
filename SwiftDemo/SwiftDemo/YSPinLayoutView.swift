//
//  YSPinLayoutView.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/12/28.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import PinLayout

class YSPinLayoutView: UIView {

    private let logo: UIView = UIView()

    init() {
        super.init(frame: CGRect.zero)
        logo.backgroundColor = .red
        addSubview(logo)
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 10

        logo.pin.top(pin.safeArea).left(pin.safeArea).width(100).aspectRatio().margin(padding)
        logo.pin.height(100)
        logo.pin.right(to: self.edge.right)
        logo.pin.top(to: self.edge.top)
        logo.pin.bottom(to: self.edge.bottom)
        logo.pin.left(to: self.edge.left)
//        segmented.pin.after(of: logo, aligned: .top).right(pin.safeArea).marginHorizontal(padding)
//        textLabel.pin.below(of: segmented, aligned: .left).width(of: segmented).pinEdges().marginTop(10).sizeToFit(.width)
//        self.pin.below(of: [logo, textLabel], aligned: .left).right(to: segmented.edge.right).marginTop(10)
    }

}
