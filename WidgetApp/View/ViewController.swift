//
//  ViewController.swift
//  WidgetApp
//
//  Created by Bassuni on 7/16/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var PayButton: UIButton!
    @IBOutlet var ViewAllButton: UIButton!
    @IBOutlet var ShowTicketButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        PayButton.layer.cornerRadius = 10
        PayButton.layer.borderWidth = 1
        PayButton.layer.borderColor = UIColor(red: CGFloat(2.0/255.0), green: CGFloat(124.0/255.0), blue: CGFloat(113.0/255.0), alpha: CGFloat(1.0)).cgColor
        PayButton.clipsToBounds = true

        ViewAllButton.layer.cornerRadius = 10;
        ViewAllButton.layer.borderWidth = 1
        ViewAllButton.layer.borderColor = UIColor(red: CGFloat(2.0/255.0), green: CGFloat(124.0/255.0), blue: CGFloat(113.0/255.0), alpha: CGFloat(1.0)).cgColor
        ViewAllButton.clipsToBounds = true

        ShowTicketButton.layer.cornerRadius = 10;
        ShowTicketButton.layer.borderWidth = 1
        ShowTicketButton.layer.borderColor = UIColor(red: CGFloat(2.0/255.0), green: CGFloat(124.0/255.0), blue: CGFloat(113.0/255.0), alpha: CGFloat(1.0)).cgColor
        ShowTicketButton.clipsToBounds = true






        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLabel.text = "  Activity"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }


}

