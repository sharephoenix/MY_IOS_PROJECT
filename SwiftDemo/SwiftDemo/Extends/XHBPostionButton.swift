//
//  RightImageButton.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Foundation

class XHBPostionButton: UIButton {

    public enum BTNPOSITION {
        case labelLeftImageRight
        case labelRightImageLeft
        case labelTopImageBottom
        case labelBottomImageTop
    }
    var position: BTNPOSITION
    var gapH: Float = 10
    var gapV: Float = 10
    var centerPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    init( frame: CGRect, gapSize: CGSize, position: BTNPOSITION) {
        self.position = position
        self.gapH = Float(gapSize.width)
        self.gapV = Float(gapSize.height)
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let currentWith = bounds.width
        let currentHeight = bounds.height
        centerPoint = CGPoint.init(x: currentWith/2.0, y: currentHeight/2.0)
        let gapHFromCenter = gapH / 2.0
        let gapVFromCenter = gapV / 2.0
        var currentImageFrame = CGRect.zero
        var currentLabelFrame = CGRect.zero
        if position == .labelBottomImageTop {
            if let titleLabel = titleLabel {
                var titleLabelFrame = titleLabel.frame
                titleLabelFrame.origin.x = centerPoint.x - titleLabelFrame.width / 2.0
                titleLabelFrame.origin.y = centerPoint.y + CGFloat(gapVFromCenter)
                currentLabelFrame = titleLabelFrame
                titleLabel.frame = currentLabelFrame
            }
            if let imageView = imageView {
                var imageViewFrame = imageView.frame
                imageViewFrame.origin.x = centerPoint.x - imageViewFrame.width / 2.0
                imageViewFrame.origin.y = centerPoint.y - imageViewFrame.height - CGFloat(gapVFromCenter)
                currentImageFrame = imageViewFrame
                imageView.frame = currentImageFrame
            }
        }
        if position == .labelTopImageBottom {
            if let titleLabel = titleLabel {
                var titleLabelFrame = titleLabel.frame
                titleLabelFrame.origin.x = centerPoint.x - titleLabelFrame.width / 2.0
                titleLabelFrame.origin.y = centerPoint.y - titleLabelFrame.height - CGFloat(gapVFromCenter)
                currentLabelFrame = titleLabelFrame
                titleLabel.frame = currentLabelFrame
            }
            if let imageView = imageView {
                var imageViewFrame = imageView.frame
                imageViewFrame.origin.x = centerPoint.x - imageViewFrame.width / 2.0
                imageViewFrame.origin.y = centerPoint.y + CGFloat(gapVFromCenter)
                currentImageFrame = imageViewFrame
                imageView.frame = currentImageFrame
            }
        }
        if position == .labelLeftImageRight {
            if let titleLabel = titleLabel {
                var titleLabelFrame = titleLabel.frame
                titleLabelFrame.origin.x = currentWith / 2.0 - titleLabelFrame.width - CGFloat(gapHFromCenter) - titleEdgeInsets.right//0.0 + contentEdgeInsets.left + titleEdgeInsets.left
                currentLabelFrame = titleLabelFrame
                titleLabel.frame = currentLabelFrame
            }
            if let imageView = imageView {
                var imageViewFrame = imageView.frame
                imageViewFrame.origin.x = currentWith / 2.0 + CGFloat(gapHFromCenter) + imageEdgeInsets.left//bounds.size.width - edgeOffset - imageView.bounds.width
                currentImageFrame = imageViewFrame
                imageView.frame = currentImageFrame
            }
        }
        if position == .labelRightImageLeft {
            if let titleLabel = titleLabel {
                var titleLabelFrame = titleLabel.frame
                titleLabelFrame.origin.x = currentWith / 2.0 + CGFloat(gapHFromCenter) + titleEdgeInsets.right//0.0 + contentEdgeInsets.left + titleEdgeInsets.left
                currentLabelFrame = titleLabelFrame
                titleLabel.frame = currentLabelFrame
            }
            if let imageView = imageView {
                var imageViewFrame = imageView.frame
                imageViewFrame.origin.x = currentWith / 2.0 - imageViewFrame.width - CGFloat(gapHFromCenter) - imageEdgeInsets.left//bounds.size.width - edgeOffset - imageView.bounds.width
                currentImageFrame = imageViewFrame
                imageView.frame = currentImageFrame
            }
        }
        if position == .labelRightImageLeft || position == .labelLeftImageRight {
            var allWidth: Double = 0.0
            if let titleLabel = titleLabel {
                allWidth += Double(titleLabel.frame.width)
            }
            if let imageView = imageView {
                allWidth += Double(imageView.frame.width)
            }
            allWidth += Double(gapH)
            let innrWith: Double = Double(bounds.width)
            if allWidth < innrWith {
                let shouldX = (innrWith - allWidth) / 2
                var xGap = 0.0 // 修正的偏移量
                if position == .labelRightImageLeft, let imageView = imageView {
                    var imageViewFrame = currentImageFrame
                    xGap = Double(imageViewFrame.origin.x - CGFloat(shouldX))
                    if xGap != 0 {
                        imageViewFrame.origin.x -= CGFloat(xGap)
                        imageView.frame = imageViewFrame
                    }
                }
                if position == .labelRightImageLeft, let titleLabel = titleLabel {
                    var titleLabelFrame = currentLabelFrame
                    if xGap != 0 {
                        titleLabelFrame.origin.x -= CGFloat(xGap)
                        titleLabel.frame = titleLabelFrame
                    }
                }
                if position == .labelLeftImageRight, let titleLabel = titleLabel {
                    var titleLabelFrame = currentLabelFrame
                    xGap = Double(titleLabelFrame.origin.x - CGFloat(shouldX))
                    if xGap != 0 {
                        titleLabelFrame.origin.x -= CGFloat(xGap)
                        titleLabel.frame = titleLabelFrame
                    }
                }
                if position == .labelLeftImageRight, let imageView = imageView {
                    var imageViewFrame = currentImageFrame
                    if xGap != 0 {
                        imageViewFrame.origin.x -= CGFloat(xGap)
                        imageView.frame = imageViewFrame
                    }
                }
            }
        }
    }
}
