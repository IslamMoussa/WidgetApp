//
//  RequestDetailsViewController.swift
//  WidgetApp
//
//  Created by Bassuni on 7/18/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class RequestDetailsViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!

    //button underline for segmentedcontrol
    let buttonBar: UIView = {
      let b = UIView()
      b.translatesAutoresizingMaskIntoConstraints = false
      b.backgroundColor = UIColor.black
      return b
    }()


    var requestDetailsViewModel: RequestCellViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

      initUI()
    }

}






extension RequestDetailsViewController{


    func initUI(){
    segmentedControl.setTitleTextAttributes([
        NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18) as Any,
        NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ], for: .normal)

    segmentedControl.setTitleTextAttributes([
        NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18) as Any,
        NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)

        segmentedControl.addTarget(self, action: #selector(changeAndRepeat(_:)), for: .valueChanged)

        view.addSubview(buttonBar)

        
        buttonBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true



    }

   @objc func changeAndRepeat(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }

    switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            //historyView.isHidden = true
            //popularView.isHidden = false
                break;
        case 1:
            //historyView.isHidden = false
            //popularView.isHidden = true
                break;
        case 2:
            //historyView.isHidden = false
            //popularView.isHidden = true
                break;
        default:
            break;
        }
    }




}
