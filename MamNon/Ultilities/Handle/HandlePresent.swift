//
//  HandlePresent.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit

class HandlePresent: NSObject {
    func showPopupNotificationDetail(objNotifi: NotificationModel, root: UIViewController){
        let vc = ContainerNotiticationDetailFloatingViewController()
        vc.objNotifi = objNotifi
        vc.modalPresentationStyle = .overFullScreen
        root.present(vc, animated: false, completion: nil)
    }
    func showPickerViewChoiceViewController(indexChoice: Int = 0, arrayChoice: [String] ,root: UIViewController)  {
        let vc = PickerViewChoiceViewController()
        vc.indexChoice = indexChoice
        vc.arrayPicker = arrayChoice
        vc.delegate = root as! PickerViewChoiceViewControllerDelegate
        vc.modalPresentationStyle = .overFullScreen
        root.present(vc, animated: false, completion: nil)
    
       
    }
    
    func showFeatureViewController(isEdit: Bool, root: UIViewController) {
        let vc = FeatureViewController()
        vc.isEdit = isEdit
        vc.delegate = root as? FeatureViewControllerDelegate
        root.present(vc, animated: true, completion: nil)
    }
    
    
    func showChoiceImageViewController(maxItem : Int = 10, arrayImageChoice: [ImageLibraryModel] = [], root: UIViewController) {
        let vc = ContainerChoiceImaeFloatingViewController()
        vc.delegate = root as? ContainerChoiceImaeFloatingViewControllerDelegate
        vc.arrayMediaChoiced = arrayImageChoice
        vc.maxItem = maxItem
        vc.modalPresentationStyle = .overFullScreen
        root.present(vc, animated: false, completion: nil)
    }
}
