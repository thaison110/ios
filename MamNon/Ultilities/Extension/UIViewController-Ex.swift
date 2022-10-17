//
//  UIViewController-Ex.swift
//  HoM
//
//  Created by Nguyen Tien on 12/27/20.
//  Copyright © 2020 iAm2r. All rights reserved.
//

import Foundation
import UIKit
import Toast

extension UIViewController {
    func changeTitle(title:String) {
        self.navigationItem.title = title
    }
    func showToast(message: String) {
        self.view.makeToast(message)
    }
    public static var current: UIViewController? {
        if let controller = UIApplication.shared.keyWindow?.rootViewController {
            return findCurrent(controller)
        }
        return nil
    }

    private static func findCurrent(_ controller: UIViewController) -> UIViewController {
        if let controller = controller.presentedViewController {
            return findCurrent(controller)
        }
        else if let controller = controller as? UISplitViewController, let lastViewController = controller.viewControllers.first, controller.viewControllers.count > 0 {
            return findCurrent(lastViewController)
        }
        else if let controller = controller as? UINavigationController, let topViewController = controller.topViewController, controller.viewControllers.count > 0 {
            return findCurrent(topViewController)
        }
        else if let controller = controller as? UITabBarController, let selectedViewController = controller.selectedViewController, (controller.viewControllers?.count ?? 0) > 0 {
            return findCurrent(selectedViewController)
        }
        else {
            return controller
        }
    }
    
    // check xem uiviewcontroller đó cái pải là presen từ màn trươc đến hay ko. nếu presen thì trả ra true
    var isModal: Bool {
        return presentingViewController != nil ||
            navigationController?.presentingViewController?.presentedViewController === navigationController ||
            tabBarController?.presentingViewController is UITabBarController
    }
}
