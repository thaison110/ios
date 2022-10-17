//
//  AccountViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 18/09/2022.
//

import UIKit
import CarbonKit

enum TypeViewAccount : Int {
    case infoChildrent = 0
    case infoParent = 1
}

class AccountViewController: UIViewController {
    
  
    @IBOutlet weak var labelParent: UILabel!
    @IBOutlet weak var labelStudent: UILabel!
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var viewStudent: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewHeader: UIView!
    var carbonTabSwipeNavigation : CarbonTabSwipeNavigation? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addViewHeader()
        scollToParentsOrStudent(isCheckStudent: false)
        initCarbonkitTapSwipe(items: ["student", "parent"])
    }

    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    
    func scollToParentsOrStudent(isCheckStudent: Bool){
        if isCheckStudent {
            self.viewStudent.backgroundColor = UIColor.init(hexString: "#FF7917")
            self.labelStudent.textColor = UIColor.white
            self.viewParent.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.labelParent.textColor = UIColor.black
        }else{
            self.viewStudent.backgroundColor = UIColor.init(hexString: "#FFFAF4")
            self.labelStudent.textColor = UIColor.black
            self.viewParent.backgroundColor = UIColor.init(hexString: "#FF7917")
            self.labelParent.textColor = UIColor.white
        }
    }
    
    @IBAction func pressedChoiceStudent(_ sender: Any) {
        scollToParentsOrStudent(isCheckStudent: true)
        self.carbonTabSwipeNavigation?.setCurrentTabIndex(0, withAnimation: true)
    }
    @IBAction func pressedChoiceParent(_ sender: Any) {
        scollToParentsOrStudent(isCheckStudent: false)
        self.carbonTabSwipeNavigation?.setCurrentTabIndex(1, withAnimation: true)
    }
    
    func initCarbonkitTapSwipe(items:[String]){
//        var items:[String] = []
        
        
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


extension AccountViewController :  CarbonTabSwipeNavigationDelegate{
    // MARK: Carbon
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        // return viewController at index
        if index == TypeViewAccount.infoChildrent.rawValue {
            let view  = AccountStudentViewController()
            return view
        }else if index == TypeViewAccount.infoParent.rawValue {
            let view  = AccountParentViewController()
            return view
            
        }
        
        return UIViewController()
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        if index == TypeViewAccount.infoChildrent.rawValue {
            self.scollToParentsOrStudent(isCheckStudent: true)
        }else if index == TypeViewAccount.infoParent.rawValue {
            self.scollToParentsOrStudent(isCheckStudent: false)
        }

    }
}
