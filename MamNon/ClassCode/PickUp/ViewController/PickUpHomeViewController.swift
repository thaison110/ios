//
//  PickUpHomeViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit
import CarbonKit

class PickUpHomeViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewPickUpForm: UIView!
    @IBOutlet weak var viewShuttlePerson: UIView!
  
    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var labelPickUpForm: UILabel!
    @IBOutlet weak var labelShuttlePerson: UILabel!
    @IBOutlet weak var labelHistory: UILabel!
    @IBOutlet weak var viewContent: UIView!
    var carbonTabSwipeNavigation : CarbonTabSwipeNavigation? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        // Do any additional setup after loading the view.
        scollPageViewController(index: 0)
        initCarbonkitTapSwipe(items: ["PickUp","ShuttlePerson","History"])
    }


    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    @IBAction func pressedPickUp(_ sender: Any) {
        scollPageViewController(index: 0)
        carbonTabSwipeNavigation?.setCurrentTabIndex(0, withAnimation: true)
    }
    @IBAction func pressedShuttlePerson(_ sender: Any) {
        scollPageViewController(index: 1)
        carbonTabSwipeNavigation?.setCurrentTabIndex(1, withAnimation: true)
    }
    @IBAction func pressedHistory(_ sender: Any) {
        scollPageViewController(index: 2)
        carbonTabSwipeNavigation?.setCurrentTabIndex(2, withAnimation: true)
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func scollPageViewController(index: Int){
        
        if index == 0 {
            self.viewPickUpForm.backgroundColor = UIColor.init(hexString: "#FF7917")
            self.viewShuttlePerson.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.viewHistory.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.labelPickUpForm.textColor = UIColor.white
            self.labelShuttlePerson.textColor = UIColor.black
            self.labelHistory.textColor = UIColor.black
        }else if index == 1{
            self.viewPickUpForm.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.viewShuttlePerson.backgroundColor = UIColor.init(hexString: "#FF7917")
            self.viewHistory.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.labelPickUpForm.textColor = UIColor.black
            self.labelShuttlePerson.textColor = UIColor.white
            self.labelHistory.textColor = UIColor.black
        }else{
            self.viewPickUpForm.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.viewShuttlePerson.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.viewHistory.backgroundColor = UIColor.init(hexString: "#FF7917")
            self.labelPickUpForm.textColor = UIColor.black
            self.labelShuttlePerson.textColor = UIColor.black
            self.labelHistory.textColor = UIColor.white
        }
        

    }
    
    func initCarbonkitTapSwipe(items:[String]){

        
        
        self.carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation?.toolbar.barTintColor = UIColor.clear
        self.carbonTabSwipeNavigation?.insert(intoRootViewController: self, andTargetView: self.viewContent)
        self.carbonTabSwipeNavigation?.toolbar.isTranslucent = false
        self.carbonTabSwipeNavigation?.carbonSegmentedControl?.backgroundColor = UIColor.clear
        self.carbonTabSwipeNavigation?.accessibilityPath?.lineWidth = 0

        self.carbonTabSwipeNavigation?.setNormalColor(UIColor.init(hexString: "#966E0B"), font:   UIFont(name: Constants.FontName.kFontSFProRegular, size: 12) as! UIFont)
        self.carbonTabSwipeNavigation?.setSelectedColor(UIColor.init(hexString: "#972D00"), font:  UIFont(name: Constants.FontName.kFontSFProRegular, size: 12) as! UIFont)
        self.carbonTabSwipeNavigation?.setIndicatorColor(UIColor.clear)
        self.carbonTabSwipeNavigation?.setTabBarHeight(0)
//        self.carbonTabSwipeNavigation?.setTabExtraWidth(0.001)
        self.carbonTabSwipeNavigation?.toolbar.isHidden = true
        
        self.carbonTabSwipeNavigation?.pagesScrollView?.isScrollEnabled = true

        
    }

}


extension PickUpHomeViewController :  CarbonTabSwipeNavigationDelegate{
    // MARK: Carbon
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        // return viewController at index
        if index == 0 {
            let view  = PickUpViewController()
            return view
        }else if index == 1{
            let view  = ShuttlePersonViewController()
            return view
            
        }else{
            let view  = HistoryPickUpViewController()
            return view
            
        }
        

    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        scollPageViewController(index: Int(index))

    }
}
