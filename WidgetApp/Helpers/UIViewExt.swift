//
//  UIViewExt.swift
//  WidgetApp
//
//  Created by Bassuni on 7/22/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func radiusWithBorder(cornerRadius: CGFloat, borderWidth: CGFloat, color: CGColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = cornerRadius
    }
}
