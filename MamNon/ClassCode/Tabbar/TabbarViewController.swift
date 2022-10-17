//
//  TabbarViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    static var singleton: TabbarViewController? = nil
    class var sharedInstance : TabbarViewController {
        guard let sg = self.singleton else {
            let sg = TabbarViewController()
            self.singleton = sg
            return sg

        }
        return sg
    }
    
    let arrayOfImageNameForUnselectedState = ["ic_TabbarHomeUnselect","ic_TabbarFeatureUnselect","ic_TabbarNotifiUnselect","ic_TabbarAcountUnselect"]
    let arrayOfImageNameForSelectedState = ["ic_TabbarHomeSelect","ic_TabbarFeatureSelect","ic_TabbarNotifiSelect","ic_TabbarAcountSelect"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabbar()
        GlobalData.sharedInstance.arrayFeaturePin = Common.readArrayFeatureToUserDefault()
        // Do any additional setup after loading the view.
    }
    
    func initTabbar() {
        let home =  HomeViewController()
        let homeNavi = UINavigationController.init(rootViewController: home)
        homeNavi.isNavigationBarHidden = true
        homeNavi.tabBarItem = UITabBarItem(
            title: "Trang chù",
            image: UIImage (named: ""),
            tag:0)
        
        let feature =  FeatureViewController()
        let featureNavi = UINavigationController.init(rootViewController: feature)
        featureNavi.isNavigationBarHidden = true
        featureNavi.tabBarItem = UITabBarItem(
            title: "Tính năng",
            image: UIImage (named: ""),
            tag:1)
        
        let notifi = NotificationViewController()
        let notifiNavi = UINavigationController.init(rootViewController: notifi)
        notifiNavi.isNavigationBarHidden = true
        notifiNavi.tabBarItem = UITabBarItem(
            title: "Thông báo",
            image: UIImage (named: ""),
            tag:2)
        let acount = AccountViewController()
        let acountNavi = UINavigationController.init(rootViewController: acount)
        acountNavi.isNavigationBarHidden = true
        acountNavi.tabBarItem = UITabBarItem(
            title: "Tài Khoản",
            image: UIImage (named: ""),
            tag:2)
        
        let controllers = [homeNavi, featureNavi, notifiNavi, acountNavi]
        self.viewControllers = controllers
        UITabBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.tabBar.isTranslucent = true
//        self.tabBar.layer.borderWidth = 0.50
//        self.tabBar.layer.borderColor = UIColor.clear.cgColor
//        self.tabBar.clipsToBounds = true
        self.configTabbar()
    }
    func configTabbar() {
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        let selectedColor   = #colorLiteral(red: 1, green: 0.4745098039, blue: 0.09019607843, alpha: 1)
        let unselectedColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
        
        let nameFont =  UIFont(name: Constants.FontName.kFontSFProRegular, size: 13)! //UIFont.systemFont(ofSize: 13)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: nameFont as Any, NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
      
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        self.tabBar.isTranslucent = false
        
       
    }

}
