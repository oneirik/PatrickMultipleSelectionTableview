 
![alt text](https://github.com/pratikpanchal13/PatrickMultipleSelectionTableview/blob/master/Pratik.gif)

# PatrickMultipleSelectionTableview

[![CI Status](http://img.shields.io/travis/pratikpanchal131/PatrickMultipleSelectionTableview.svg?style=flat)](https://travis-ci.org/pratikpanchal131/PatrickMultipleSelectionTableview)
[![Version](https://img.shields.io/cocoapods/v/PatrickMultipleSelectionTableview.svg?style=flat)](http://cocoapods.org/pods/PatrickMultipleSelectionTableview)
[![License](https://img.shields.io/cocoapods/l/PatrickMultipleSelectionTableview.svg?style=flat)](http://cocoapods.org/pods/PatrickMultipleSelectionTableview)
[![Platform](https://img.shields.io/cocoapods/p/PatrickMultipleSelectionTableview.svg?style=flat)](http://cocoapods.org/pods/PatrickMultipleSelectionTableview)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 4.2
* Xcode 8
* iOS 9.0+

## Installation

#### [CocoaPods](http://cocoapods.org) (recommended)

MST1 is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile

````ruby
use_frameworks!

pod 'PatrickMultipleSelectionTableview', :git => 'https://github.com/oneirik/PatrickMultipleSelectionTableview.git'
````


## USAGE

import PatrickMultipleSelectionTableview in ViewController.swift

````ruby   
import PatrickMultipleSelectionTableview
````

To Show MulitpleSelection Controller in your Controller Call Function showMultipleSelection()
````ruby
func showMultipleSelectionTableview()
{

    if let controller = PKMulipleSelectionVC.controller() {
        controller.arrContent = ["IPhone","IMac","IPad","MacBook","IPod","MacMini","Apple TV"]  // Pass Array Data
        controller.objGetSelectedIndex = [1,5] // Preselection
        
        controller.canAcceptEmptySelection = false
        controller.showsCancelButton = true
        
        controller.backgroundColorDoneButton        = UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        controller.backgroundColorHeaderView        = UIColor(red: 76.0/255.0, green: 82.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        controller.backgroundColorTableView         = UIColor(red: 59.0/255.0, green: 65.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        controller.backgroundColorCellTitle         = UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        controller.backgroundColorDoneTitle         = UIColor.white
        controller.backgroundColorSelectALlTitle    = UIColor.white



        controller.didFinishWithSelection = { selectedData, selectedIndexes in
            print("Did finish selection: \(selectedData) -> \(selectedIndexes)")
        }

        controller.didCancelSelection = {
            print("Did cancel selection...")
        }

        controller.show()
    }
}
    
````

## Author

pratikpanchal131, pratik.panchal13@gmail.com

## License

PatrickMultipleSelectionTableview is available under the MIT license. See the LICENSE file for more info.
