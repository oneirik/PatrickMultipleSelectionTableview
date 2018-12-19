//
//  PKMulipleSelectionVC.swift
//  Pods
//
//  Created by indianic on 03/04/17.
//
//

import UIKit

open class PKMulipleSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var window : UIWindow? = nil
    
    open var showsCancelButton : Bool = false {
        didSet{
            if self.isViewLoaded{
                cancelButton.isHidden = !showsCancelButton
            }
        }
    }
    open var canAcceptEmptySelection : Bool = true {
        didSet{
            if self.isViewLoaded{
                updateDoneButtonEnabled()
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////
    //MARK: - Class Methods
    
    open class func controller() -> PKMulipleSelectionVC?{
        let podBundle = Bundle(for: PKMulipleSelectionVC.self)
        if let bundleURL = podBundle.url(forResource: "PatrickMultipleSelectionTableview", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)
            let controller : PKMulipleSelectionVC? = storyboard.instantiateViewController(withIdentifier: "PKMulipleSelectionVC") as? PKMulipleSelectionVC
            
            return controller
        }
        
        return nil
    }
    
    ////////////////////////////////////////////////////////////////////////
    //MARK: - Open Functions
    
    open func show(){
        if window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window!.rootViewController = self
            self.window!.isHidden = true
            self.window!.windowLevel = (UIApplication.shared.keyWindow?.windowLevel ?? UIWindow.Level.normal) + 10
            self.window!.backgroundColor = UIColor.clear
            self.view.alpha = 0.0
        }
        
        self.window?.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.alpha = 1.0
        }, completion: nil)
    }
    
    open func dismiss(){
        if let window = self.window{
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.view.alpha = 0.0
            }, completion: { (finish) in
                window.isHidden = true
                window.rootViewController = nil
                self.window = nil
                window.removeFromSuperview()
                })
        }
    }
    
    ////////////////////////////////////////////////////////////////////////
    //MARK: - Style Vars
    
    open var backgroundColorHeaderView: UIColor       = UIColor(red: 76.0/255.0, green: 82.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    open var backgroundColorDoneButton: UIColor       = UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    open var backgroundColorTableView: UIColor        = UIColor(red: 59.0/255.0, green: 65.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    open var backgroundColorSelectALlTitle: UIColor   = UIColor.white
    open var backgroundColorCellTitle: UIColor        = UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    open var backgroundColorDoneTitle: UIColor        = UIColor.white
    
    ////////////////////////////////////////////////////////////////////////
    //MARK: - Completion functions with completion handlers
    
    open var didFinishWithSelection:( _ selectedData : [String], _ selectedIndexes : [Int])->() = {selectedData, selectedIndexes  in}
    open var didCancelSelection:()->() = {}
    
    ////////////////////////////////////////////////////////////////////////
    //MARK: - Outlets and other variables
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var imgSelectAll: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var isSelectAll : Bool = false
    
    //open Variable Declaration For Preselection Indexes
    open var objGetSelectedIndex: [Int] = [] { // HomeVC
        didSet {
            if self.isViewLoaded {
                updatePreselection()
            }
        }
    }
    //open Local Variable Declaration Content And Selection
    open var arrContent: [String] = [] {
        didSet {
            if self.isViewLoaded {
                updateSelectAll()
            }
        }
    }
    open var selectedIndex: [Int] = [] {
        didSet {
            if self.isViewLoaded {
                updateSelectAll()
                updateDoneButtonEnabled()
            }
        }
    }
    
    //MARK: - View Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetUpUI()   // Set UI
        
        tblView.allowsMultipleSelection = true
        tblView.tableFooterView = UIView(frame: .zero)
        
        cancelButton.isHidden = !showsCancelButton
        
        updatePreselection()
    }
    
    ////////////////////////////////////////////////////////////////////////
    //MARK: - Utilities
    
    func updateDoneButtonEnabled(){
        if(self.selectedIndex.count == 0){
            btnDone.isEnabled = canAcceptEmptySelection
        }else if !btnDone.isEnabled {
            btnDone.isEnabled = true
        }
    }
    
    func updatePreselection(){
        selectedIndex.removeAll()
        selectedIndex.append(contentsOf: objGetSelectedIndex)
        updateSelectAll()
        self.tblView.reloadData()
    }
    
    func updateSelectAll(){
        let allSelected : Bool = selectedIndex.count == arrContent.count
        if(allSelected != isSelectAll){
            let imgUnCheck = UIImage(named:"unCheck", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
            let imgCheck = UIImage(named:"Check", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
            
            let img:UIImage = (allSelected ? imgCheck : imgUnCheck)!
            imgSelectAll.image = img
            isSelectAll = allSelected
        }
    }
    
    //MARK: - Set Up UI
    open func SetUpUI(){
        self.tblView.backgroundColor = backgroundColorTableView
        self.btnSelectAll.setTitleColor(backgroundColorSelectALlTitle, for: UIControl.State.normal)
        self.viewHeader.backgroundColor = backgroundColorHeaderView
        self.btnDone.backgroundColor = backgroundColorDoneButton
        self.btnDone.setTitleColor(backgroundColorDoneTitle, for: UIControl.State.normal)
    }
    
    @IBAction func btnCancelClicked(_ sender: AnyObject) {
        self.didCancelSelection()
        
        dismiss()
    }
    
    @IBAction func btnSelectALL(_ sender: Any) {
        let allSelected = isSelectAll
        selectedIndex.removeAll()
        if(!allSelected){
            for i in 0 ..< arrContent.count {
                selectedIndex.append(i)
            }
        }
        
        updateSelectAll()
        tblView.reloadData()
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        var passingDataToHomeVC : [String] = []
        var passingSelectedIndexes : [Int] = []
        
        for i in selectedIndex.sorted() {
            if i >= 0 && i < arrContent.count {
                passingDataToHomeVC.append(arrContent[i])
                passingSelectedIndexes.append(i)
            }
        }
        
        self.didFinishWithSelection(passingDataToHomeVC, passingSelectedIndexes)  // Passing Finish Selection Using Blocks to Parent VC
        
        dismiss()
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60.0;
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContent.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell
        cell?.lblName.text = "\(arrContent[indexPath.row])"
        let aStrImg:String = selectedIndex.contains((indexPath.row)) ? "Check": "unCheck"
        let image = UIImage(named: aStrImg, in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
        cell?.imgVewCheckUnckeck.image = image;
        
        cell?.contentView.backgroundColor = backgroundColorTableView
        cell?.lblName.textColor = backgroundColorCellTitle
        return cell!
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.contains(indexPath.row){
            let index  = indexPath.row
            if let arrayIndex = selectedIndex.firstIndex(of: index){
                selectedIndex.remove(at: arrayIndex)
            }
        }else{
            let index  = indexPath.row
            if !selectedIndex.contains(index){
                selectedIndex.append(index)
            }
        }
        updateSelectAll()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    //MARK: - View Touch Event
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            if touch.view != self.viewContent {
                if touch.view != viewHeader.viewWithTag(1) {
                    if touch.view != imgSelectAll.viewWithTag(2) {
                        
                        self.willMove(toParent: nil)
                        self.view.removeFromSuperview()
                        self.removeFromParent()
                    }
                }
            }
        }
        super.touchesBegan(touches, with:event)
    }
}
    
// TableView Cell
open class Cell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVewCheckUnckeck: UIImageView!
}
