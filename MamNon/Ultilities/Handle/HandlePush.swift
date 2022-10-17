//
//  HandlePush.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import UIKit

class HandlePush: NSObject {
   
    
    func goToLogin() {
//        let loginVC = UINavigationController(rootViewController:  LoginViewController())
        let loginVC = UINavigationController.init(rootViewController: LoginViewController())
        loginVC.isNavigationBarHidden = true
        Common.setRootViewController(rootVC: loginVC)
       
    }
    
    func gotoTabBar()  {
        TabbarViewController.singleton = nil
        let mainTabbar = TabbarViewController.sharedInstance
        Common.setRootViewController(rootVC: mainTabbar)
    }
    
    func pushToHomeMessage(root: UIViewController)  {
        let vc = HomeMessageViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToMessageDetail(personChat: ChatPersonModel,root: UIViewController)  {
        let vc = MessageDetailViewController()
        vc.personChat = personChat
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToMessageCreateChat(arrayPersonChat: [ChatPersonModel],root: UIViewController)  {
        let vc = MessageCreateChatViewController()
        vc.arrayChatPersion = arrayPersonChat
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToMedicineHome(root: UIViewController)  {
        let vc = MedicineHomeViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToCreateMedicine(root: UIViewController)  {
        let vc = CreateMedicineViewController()
        vc.delegate = root as? CreateMedicineViewControllerDelegate
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushToPickUpHome(root: UIViewController)  {
        let vc = PickUpHomeViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToCreatePickUp(typePickUp: Int,root: UIViewController)  {
        let vc = CreatePickUpViewController()
        vc.typeTimePickUp = typePickUp
        vc.delegate = root as! CreatePickUpViewControllerDelegate
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToCreateShuttlePerson(objEdit: ShuttlePersonModel? = nil,root: UIViewController)  {
        let vc = CreateShuttlePersonViewController()
        vc.objEditPersonPickUp = objEdit
        vc.delegate = root as! CreateShuttlePersonViewControllerDelegate
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushNews(root: UIViewController) {
        let vc = NewsViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    

    func pushDetailNews(root: UIViewController,newsModel:NewsModel? = nil, idPost : Int? = nil ) {
        let vc = DetailNewsViewController()
        vc.newsModel = newsModel
        vc.idPostNotifi = idPost
        root.navigationController?.pushViewController(vc, animated: true)
    }
    

    func pusDetailPersonPickUp(objShuttlePerson: ShuttlePersonModel,root: UIViewController) {
        let vc = DetailPersonPickUpViewController()
        vc.objShuttlePerson = objShuttlePerson
        vc.delegate = root as! DetailPersonPickUpViewControllerDelete
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushLeaveLearn(root: UIViewController) {
        let vc = LeaveLearnViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushIndexViewController(root: UIViewController) {
        let vc = IndexViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    

    func pushFeatureViewController(isEdit: Bool, root: UIViewController) {
        let vc = FeatureViewController()
        vc.isEdit = isEdit
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushActiveDayController(root: UIViewController) {
        let vc = ActiveDayViewController()
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushChangePasswordViewController(root: UIViewController) {
        let vc = ChangePasswordViewController()
        vc.delegate  = root as? ChangePasswordViewControllerDelegate
        root.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func pushMedicineDetailViewController(objMedicine: MedicineModel,root: UIViewController) {
        let vc = MedicineDetailViewController()
        vc.objMedicine = objMedicine
        vc.delete = root as? MedicineDetailViewControllerDelete
        root.navigationController?.pushViewController(vc, animated: true)
    }
}
