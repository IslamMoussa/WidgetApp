//
//  AutoResizeTableView.swift
//  WidgetApp
//
//  Created by Bassuni on 7/20/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

class AutoResizeTableView: UITableView
{
    override var intrinsicContentSize: CGSize
    {
        self.layoutIfNeeded()
        return self.contentSize

    }

    override var contentSize: CGSize
        {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData()
    {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

}
