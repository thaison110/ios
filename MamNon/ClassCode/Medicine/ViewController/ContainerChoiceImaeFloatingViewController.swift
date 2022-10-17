//
//  ContainerChoiceImaeFloatingViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 28/09/2022.
//

import UIKit

protocol ContainerChoiceImaeFloatingViewControllerDelegate {
    func choiceListImage(listImage: [ImageLibraryModel])
}


class ContainerChoiceImaeFloatingViewController: UIViewController,FloatingPanelControllerDelegate {
    var fpc: FloatingPanelController!
    var delegate : ContainerChoiceImaeFloatingViewControllerDelegate?
    var arrayMediaChoiced : [ImageLibraryModel] = []
    var maxItem : Int = 40
    override func viewDidLoad() {
        super.viewDidLoad()
        initFloating()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fpc.move(to: .full, animated: true)
    }


    func initFloating(){
        fpc = FloatingPanelController()
               
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
               // Set a content view controller.
        let contentVC =  ChoiceImageViewController()
        contentVC.arrayMediaChoiced = self.arrayMediaChoiced
        contentVC.delegate = self
        contentVC.maxItem = self.maxItem
        fpc.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
        fpc.track(scrollView: contentVC.collectionView)
        fpc.surfaceView.backgroundColor = UIColor.clear
        fpc.surfaceView.shadowHidden = false
        fpc.surfaceView.grabberHandle.isHidden = true
        let backdropTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackdrop(tapGesture:)))
        fpc.backdropView.addGestureRecognizer(backdropTapGesture)
               
               // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
    }
    
    
    @objc func handleBackdrop(tapGesture: UITapGestureRecognizer? = nil) {
        fpc.move(to: .tip, animated: true) {
            self.dismiss(animated: false)
        }
    }
    
    func floatingPanelDidEndDraggingToRemove(_ vc: FloatingPanelController, withVelocity velocity: CGPoint) {
        
    }
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        
        
    }
    
   
    
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {

        
    }
    
    func floatingPanelDidEndDecelerating(_ vc: FloatingPanelController) {
        
        switch  vc.position {
            case .full:
                break
            case .half:
                self.dismiss(animated: false)
                break
            case .tip:
                self.dismiss(animated: false)
                break
            case .hidden:
                    
                break
            default:
               
                break
        }
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return ChoiceImageFloatingPanelLayout()
    }


}

class ChoiceImageFloatingPanelLayout: FloatingPanelLayout {

    public var initialPosition: FloatingPanelPosition {
        return .tip
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return  SCREEN_HEIGHT - 110 - (SCREEN_WIDTH - 24)/2 - Common.getBottomPadding() // A top inset from safe area
//            case .half: return 200.0 // A bottom inset from the safe area
        case .tip: return 0 - Common.getBottomPadding() // A bottom inset from the safe area
            
            default: return nil // Or `case .hidden: return nil`
        }
    }
}

extension ContainerChoiceImaeFloatingViewController : ChoiceImageViewControllerDelegate {
    func close(listImage: [ImageLibraryModel]?) {
        if let array = listImage {
            if let delegate = self.delegate {
                delegate.choiceListImage(listImage: array)
            }
        }
        fpc.move(to: .tip, animated: true) {
            self.dismiss(animated: false)
        }
    }
    
    
    func pickListImage(listImage: [ImageLibraryModel]) {
        
    }
    
    
    
    
}
