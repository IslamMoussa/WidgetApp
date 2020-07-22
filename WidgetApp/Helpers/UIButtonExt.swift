//
//  UIButtonExt.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func radiusWithBorder(cornerRadius: CGFloat, borderWidth: CGFloat, hexColor: String) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor(hexString: hexColor).cgColor
        self.clipsToBounds = true

    }
}
