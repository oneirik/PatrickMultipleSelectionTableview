//
//  ViewController.swift
//  PatrickMultipleSelectionTableview
//
//  Created by pratikpanchal131 on 04/03/2017.
//  Copyright (c) 2017 pratikpanchal131. All rights reserved.
//

import UIKit
import PatrickMultipleSelectionTableview

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func launchTable(_ sender: Any) {
        
        if let vc = PKMulipleSelectionVC.controller() {
            vc.arrContent = ["IPhone","IMac","IPad","MacBook","IPod","MacMini","Apple TV"]  // Pass Array Data
            vc.objGetSelectedIndex = [1,5] // Preselection
            vc.canAcceptEmptySelection = true
            vc.showsCancelButton = true
            
            vc.backgroundColorDoneButton        = UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            vc.backgroundColorHeaderView        = UIColor(red: 76.0/255.0, green: 82.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            vc.backgroundColorTableView         = UIColor(red: 59.0/255.0, green: 65.0/255.0, blue: 66.0/255.0, alpha: 1.0)
            vc.backgroundColorCellTitle         = UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            vc.backgroundColorDoneTitle         = UIColor.white
            vc.backgroundColorSelectALlTitle    = UIColor.white
            
            
            // Data Passing Usning Block
            vc.didFinishWithSelection = { arrayData, selectedIndexes in
                print("Did finish selection: \(arrayData) -> \(selectedIndexes)")
            }
            
            vc.didCancelSelection = {
                print("Did cancel selection...")
            }
            
            vc.show()
        }
    }
}

