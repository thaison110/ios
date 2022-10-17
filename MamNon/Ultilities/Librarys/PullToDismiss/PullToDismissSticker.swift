//
//  PullToDismissSticker.swift
//  KingHub
//
//  Created by BigSun on 4/17/19.
//  Copyright © 2019 VivaVietNam. All rights reserved.
//

import Foundation
import UIKit

protocol PullToDismissStickerDelegate {
    func updateAlphaView(rate:CGFloat)
}

open class PullToDismissSticker: NSObject {
    
    var lastOffset:CGPoint? = CGPoint (x: 0, y: 0)
    var lastOffsetCapture:TimeInterval? = 0
    var isScrollingFast: Bool = false
    
    public struct Defaults {
        private init() {}
        public static let dismissableHeightPercentage: CGFloat = 0.33
    }
    
    open var backgroundEffect: BackgroundEffect? = ShadowEffect.default
    open var edgeShadow: EdgeShadow? = EdgeShadow.default
    
    var delegateSticker : PullToDismissStickerDelegate?
    public var dismissAction: (() -> Void)?
    public weak var delegate: UIScrollViewDelegate? {
        didSet {
            var delegates: [UIScrollViewDelegate] = [self]
            if let delegate = delegate {
                delegates.append(delegate)
            }
            proxy = ScrollViewDelegateProxy(delegates: delegates)
        }
    }
    public var dismissableHeightPercentage: CGFloat = Defaults.dismissableHeightPercentage {
        didSet {
            dismissableHeightPercentage = min(max(0.0, dismissableHeightPercentage), 1.0)
        }
    }
    
    fileprivate var viewPositionY: CGFloat = 0.0
    fileprivate var dragging: Bool = false
    fileprivate var previousContentOffsetY: CGFloat = 0.0
    fileprivate weak var viewController: UIViewController?
    
    private var __scrollView: UIScrollView?
    
    private var proxy: ScrollViewDelegateProxy? {
        didSet {
            __scrollView?.delegate = proxy
        }
    }
    
    private var panGesture: UIPanGestureRecognizer?
    private var backgroundView: UIView?
    private var navigationBarHeight: CGFloat = 0.0
    private var blurSaturationDeltaFactor: CGFloat = 1.8
    convenience public init?(scrollView: UIScrollView) {
        guard let viewController = type(of: self).viewControllerFromScrollView(scrollView) else {
            print("a scrollView must be on the view controller.")
            return nil
        }
        self.init(scrollView: scrollView, viewController: viewController)
    }
    
    public init(scrollView: UIScrollView, viewController: UIViewController, navigationBar: UIView? = nil) {
        super.init()
        self.proxy = ScrollViewDelegateProxy(delegates: [self])
        self.__scrollView = scrollView
        self.__scrollView?.delegate = self.proxy
        self.viewController = viewController
        
        if let navigationBar = navigationBar ?? viewController.navigationController?.navigationBar {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            navigationBar.addGestureRecognizer(gesture)
            self.navigationBarHeight = navigationBar.frame.height
            self.panGesture = gesture
        }
    }
    
    deinit {
        if let panGesture = panGesture {
            panGesture.view?.removeGestureRecognizer(panGesture)
        }
        
        proxy = nil
        __scrollView?.delegate = nil
        __scrollView = nil
    }
    
    fileprivate var targetViewController: UIViewController? {
        return viewController?.navigationController ?? viewController
    }
    
    private var haveShadowEffect: Bool {
        return backgroundEffect != nil || edgeShadow != nil
    }
    
    fileprivate func dismiss() {
        targetViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - shadow view
    
    private func makeBackgroundView() {
        deleteBackgroundView()
        guard let backgroundEffect = backgroundEffect else {
            return
        }
        let backgroundView = backgroundEffect.makeBackgroundViewSticker()
        backgroundView.frame = targetViewController?.view.bounds ?? .zero
        
        switch backgroundEffect.target {
        case .targetViewController:
            targetViewController?.view.addSubview(backgroundView)
            backgroundView.superview?.sendSubviewToBack(backgroundView)
            backgroundView.frame = targetViewController?.view.bounds ?? .zero
        case .presentingViewController:
            targetViewController?.presentingViewController?.view.addSubview(backgroundView)
            backgroundView.frame = targetViewController?.presentingViewController?.view.bounds ?? .zero
        }
        
        self.backgroundView = backgroundView
    }
    
    private func updateBackgroundView(rate: CGFloat) {
        guard let backgroundEffect = backgroundEffect else {
            return
        }
        
        backgroundEffect.applyEffect(view: backgroundView, rate: 0.0)
    }
    
    private func deleteBackgroundView() {
        backgroundView?.removeFromSuperview()
        backgroundView = nil
        targetViewController?.view.clipsToBounds = true
    }
    
    private func resetBackgroundView() {
        guard let backgroundEffect = backgroundEffect else {
            return
        }
        backgroundEffect.applyEffect(view: backgroundView, rate: 0.0)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            startDragging()
        case .changed:

            let diff = gesture.translation(in: gesture.view).y
            updateViewPosition(offset: diff)
            gesture.setTranslation(.zero, in: gesture.view)
        case .ended:
            finishDragging(withVelocity: .zero)
        default:
            break
        }
    }
    
    fileprivate func startDragging() {
        targetViewController?.view.layer.removeAllAnimations()
        backgroundView?.layer.removeAllAnimations()
        viewPositionY = 0.0
        makeBackgroundView()
//        targetViewController?.view.applyEdgeShadow(edgeShadow)
        if haveShadowEffect {
            targetViewController?.view.clipsToBounds = false
        }
    }
    
    fileprivate func updateViewPosition(offset: CGFloat) {
        var addOffset: CGFloat = offset
        // avoid statusbar gone
        
        
        
        if viewPositionY >= 0 && viewPositionY < 0.05 {
            addOffset = min(max(-0.01, addOffset), 0.01)
        }
        viewPositionY += addOffset
        print("previousContentOffsetY viewPositionY : \(viewPositionY)")
        targetViewController?.view.frame.origin.y = max(0.0, viewPositionY)
//        if case .some(.targetViewController) = backgroundEffect?.target {
//
//            backgroundView?.frame.origin.y = -(targetViewController?.view.frame.origin.y ?? 0.0)
//        }
        
        let targetViewOriginY: CGFloat = targetViewController?.view.frame.origin.y ?? 0.0
        let targetViewHeight: CGFloat = targetViewController?.view.frame.height ?? 0.0
        let rate: CGFloat = (1.0 - (targetViewOriginY / (targetViewHeight * dismissableHeightPercentage)))
        print("targetViewHeight : \(targetViewHeight) targetViewOriginY : \(targetViewOriginY)")
        if rate <= 0.5 {
            delegateSticker?.updateAlphaView(rate: rate)
        }
//        let rate: CGFloat = 0.0
        updateBackgroundView(rate: 0.0)
        targetViewController?.view.updateEdgeShadow(edgeShadow, rate: 0.0)
    }
    
    fileprivate func finishDragging(withVelocity velocity: CGPoint) {
        print("rate finishDragging")
        let originY = targetViewController?.view.frame.origin.y ?? 0.0
        let dismissableHeight = (targetViewController?.view.frame.height ?? 0.0) * dismissableHeightPercentage
        if originY > dismissableHeight || originY > 0 && velocity.y < 0 {
            deleteBackgroundView()
            targetViewController?.view.detachEdgeShadow()
            proxy = nil
            _ = dismissAction?() ?? dismiss()
        } else if originY != 0.0 {
            UIView.perform(.delete, on: [], options: [.allowUserInteraction], animations: { [weak self] in
                self?.targetViewController?.view.frame.origin.y = 0.0
                self?.resetBackgroundView()
                self?.targetViewController?.view.updateEdgeShadow(self?.edgeShadow, rate: 0.0)
            }) { [weak self] finished in
                if finished {
                    self?.deleteBackgroundView()
                    self?.targetViewController?.view.detachEdgeShadow()
                    self?.delegateSticker?.updateAlphaView(rate: 0.5)
                }
            }
        } else {
            self.deleteBackgroundView()
        }
        
        viewPositionY = 0.0
    }
    
    private static func viewControllerFromScrollView(_ scrollView: UIScrollView) -> UIViewController? {
        var responder: UIResponder? = scrollView
        while let r = responder {
            if let viewController = r as? UIViewController {
                return viewController
            }
            responder = r.next
        }
        return nil
    }
}
extension PullToDismissSticker: UITableViewDelegate {
}

extension PullToDismissSticker: UICollectionViewDelegate {
}

extension PullToDismissSticker: UICollectionViewDelegateFlowLayout {
}
extension PullToDismissSticker: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if dragging {
            let diff = -(scrollView.contentOffset.y - previousContentOffsetY)
            
//            print("previousContentOffsetY scrollView.Offset.y : \(scrollView.contentOffset.y)")
//            print("previousContentOffsetY -scrollView.Inset.top : \(-scrollView.contentInset.top)")
            if scrollView.contentOffset.y < -scrollView.contentInset.top || (targetViewController?.view.frame.origin.y ?? 0.0) > 0.0 {
                print("previousContentOffsetY targetView?.origin.y : \((targetViewController?.view.frame.origin.y)!)")
                updateViewPosition(offset: diff)
                scrollView.contentOffset.y = -scrollView.contentInset.top
            }
            previousContentOffsetY = scrollView.contentOffset.y
        }

    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startDragging()
        dragging = true
        previousContentOffsetY = scrollView.contentOffset.y
//        print("previousContentOffsetY scrollViewWillBeginDragging : \(previousContentOffsetY)")
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        finishDragging(withVelocity: velocity)
        dragging = false
        previousContentOffsetY = 0.0
    }
}
