//
//  UILabelExt.swift
//  WidgetApp
//
//  Created by Bassuni on 7/20/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func applyGradientWith(startColor: UIColor, endColor: UIColor) {
        var startColorRed: CGFloat = 0
        var startColorGreen: CGFloat = 0
        var startColorBlue: CGFloat = 0
        var startAlpha: CGFloat = 0
        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return
        }
        var endColorRed: CGFloat = 0
        var endColorGreen: CGFloat = 0
        var endColorBlue: CGFloat = 0
        var endAlpha: CGFloat = 0
        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return
        }
        let gradientText = self.text ?? ""
        let name: NSAttributedString.Key = NSAttributedString.Key.font
        let textSize: CGSize = gradientText.size(withAttributes: [name: self.font as Any])
        let width: CGFloat = textSize.width
        let height: CGFloat = textSize.height
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        UIGraphicsPushContext(context)
        let locations: [CGFloat] = [ 0.0, 1.0 ]
        let components: [CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha,
                                     endColorRed, endColorGreen, endColorBlue, endAlpha]
        let glossGradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: components,
                                   locations: locations, count: 2)
        context.drawLinearGradient(glossGradient!, start: CGPoint.zero, end: CGPoint(x: 0, y: textSize.height),
                                   options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        UIGraphicsPopContext()
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return
        }
        UIGraphicsEndImageContext()
        self.textColor = UIColor(patternImage: gradientImage)
    }
}
