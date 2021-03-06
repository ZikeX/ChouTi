//
//  Created by Honghao Zhang on 09/17/2015.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import UIKit

open class FadeInPresentingAnimator: Animator {

    open var overlayViewStyle: OverlayViewStyle = .normal(UIColor(white: 0.0, alpha: 0.7))

    /// Whether presenting view should be dimmed when preseting. If true, tintAdjustmentMode of presenting view will update to .Dimmed.
    open var shouldDimPresentedView: Bool = true

	override public init() {
		super.init()
		animationDuration = 0.3
	}
}

// MARK: - UIViewControllerAnimatedTransitioning
extension FadeInPresentingAnimator {
    override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)

        if presenting {
            presentingAnimation(transitionContext)
        } else {
            dismissingAnimation(transitionContext)
        }
    }

    private func presentingAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let presentedViewController = self.presentedViewController,
            let presentedView = presentedViewController.view,
            let containerView = self.containerView else {
                NSLog("ERROR: Cannot get view from UIViewControllerContextTransitioning")
                return
        }

        if presentedViewController.preferredContentSize != .zero {
            presentedView.size = presentedViewController.preferredContentSize
        } else {
            presentedView.size = containerView.size
        }
        containerView.addSubview(presentedView)

        // Initial state
        presentedView.alpha = 0.0

        UIView.animate(withDuration: animationDuration, delay: 0.0, options: UIView.AnimationOptions(), animations: {
            presentedView.alpha = 1.0
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }

    private func dismissingAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = self.fromViewController?.view else {
            NSLog("Error: Cannot get view from UIViewControllerContextTransitioning")
            return
        }

        UIView.animate(withDuration: animationDuration, delay: 0.0, options: UIView.AnimationOptions(), animations: {
            fromView.alpha = 0.0
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}

// MARK: - UIViewControllerTransitioningDelegate
public extension FadeInPresentingAnimator {
    override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let overlayPresentationController = OverlayPresentationController(presentedViewController: presented, presentingViewController: presenting, overlayViewStyle: overlayViewStyle)
        overlayPresentationController.shouldDismissOnTappingOutsideView = false
        overlayPresentationController.shouldDimPresentedView = shouldDimPresentedView

        return overlayPresentationController
    }
}
