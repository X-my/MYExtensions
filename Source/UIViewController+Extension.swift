//
//  UIViewController+Extension.swift
//  YITSwiftExtension
//
//  Created by xmy on 2020/4/8.
//

import UIKit
import RxCocoa
import NSObject_Rx

public protocol AnimatedChildViewController: UIViewController {
    
    var animationViews: [UIView] { get }
    
    var backgroundViewAlpha: CGFloat { get }
    
    var tapBackgroundToDismiss: Bool { get }
    
    var showAnimation: ChildViewControllerAnimation { get }
    
    var dismissAnimation: ChildViewControllerAnimation { get }
    
    func dismiss(completion: (() -> ())?)
    
}

public extension AnimatedChildViewController {
    
    var animationViews: [UIView] {
        return [view]
    }
    
    var backgroundViewAlpha: CGFloat {
        return 0.5
    }
    
    var tapBackgroundToDismiss: Bool {
        return true
    }
    
    var showAnimation: ChildViewControllerAnimation {
        return .fade
    }
    
    var dismissAnimation: ChildViewControllerAnimation {
        return showAnimation
    }
    
    func dismiss(completion: (() -> ())? = nil) {
        willMove(toParent: nil)
        dismissAnimation.doDismissAnimation(for: self) {
            self.view.removeFromSuperview()
            self.removeFromParent()
            completion?()
        }
    }
    
    fileprivate var backgroundButton: UIButton {
        if let button = view.viewWithTag(9999) as? UIButton {
            return button
        }
        let button = UIButton()
        button.backgroundColor = .black
        button.alpha = backgroundViewAlpha
        button.tag = 9999
        if tapBackgroundToDismiss {
            button.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(completion: nil)
            })
            .disposed(by: rx.disposeBag)
        }
        return button
    }

}

public enum ChildViewControllerAnimation {
    /// 无
    case none
    /// 淡入淡出
    case fade
    /// 从上往下掉落
    case drop
    /// 从下往上弹出
    case cover
    /// zoom in/zoom out
    case zoom
    
    fileprivate func doShowAnimation(for viewController: AnimatedChildViewController, completion:@escaping () -> ()) {
        guard self != .none else {
            completion()
            return
        }
        viewController.backgroundButton.alpha = 0
        startAnimation(for: viewController)
        UIView.animate(withDuration: 0.1, animations: {
            viewController.backgroundButton.alpha = viewController.backgroundViewAlpha
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.endAnimation(for: viewController)
            }) { _ in
                completion()
            }
        }
    }
    
    fileprivate func doDismissAnimation(for viewController: AnimatedChildViewController, completion:@escaping () -> ()) {
        guard self != .none else {
            completion()
            return
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.startAnimation(for: viewController)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                viewController.backgroundButton.alpha = 0
            }) { _ in
                completion()
            }
        }
    }
    
    fileprivate func startAnimation(for viewController: AnimatedChildViewController) {
        switch self {
        case .fade:
            viewController.animationViews.forEach({$0.alpha = 0})
        case .drop:
            viewController.animationViews.forEach({$0.transform = CGAffineTransform(translationX: 0, y: -$0.frame.maxY)})
        case .cover:
            viewController.animationViews.forEach({
                $0.alpha = 0
                $0.transform = CGAffineTransform(translationX: 0, y: $0.superview!.frame.height - $0.frame.minY)
            })
        case .zoom:
            viewController.animationViews.forEach({$0.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)})
        default:
            break
        }
    }
    
    private func endAnimation(for viewController: AnimatedChildViewController) {
        viewController.animationViews.forEach({
            $0.alpha = 1
            $0.transform = .identity
        })
    }
}

extension UIViewController {
    
    public func showChild(_ child: AnimatedChildViewController, completion: (() -> ())? = nil) {
        child.view.frame = view.bounds
        let backgroundButton = child.backgroundButton
        backgroundButton.frame = child.view.bounds
        child.view.insertSubview(backgroundButton, at: 0)
        child.view.backgroundColor = .clear
        child.view.layoutIfNeeded()
        view.addSubview(child.view)
        addChild(child)
        child.showAnimation.doShowAnimation(for: child) {
            child.didMove(toParent: self)
            completion?()
        }
    }
    
}

extension UIViewController {
    
    // MARK: - Interactive Pop Gesture Handling
    
    public func enableInteractivePopGestureRecognizer(for scrollView: UIScrollView) {
        if let screenEdgePanGestureRecognizer = screenEdgePanGestureRecognizerForNavigationController()  {
            scrollView.panGestureRecognizer.require(toFail: screenEdgePanGestureRecognizer)
        }
    }
    
    func screenEdgePanGestureRecognizerForNavigationController() -> UIScreenEdgePanGestureRecognizer? {
        guard let gestureRecognizers = navigationController?.view.gestureRecognizers  else {
            return nil
        }
        var screenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
        for gestureRecognizer in gestureRecognizers {
            if let gestureRecognizer = gestureRecognizer as? UIScreenEdgePanGestureRecognizer {
                screenEdgePanGestureRecognizer = gestureRecognizer
            }
        }
        return screenEdgePanGestureRecognizer
    }
}
