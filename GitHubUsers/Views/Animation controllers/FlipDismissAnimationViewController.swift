//
//  FlipDismissAnimationViewController.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/6/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class FlipDismissAnimationViewController: NSObject, UIViewControllerAnimatedTransitioning {

    private let destinationFrame: CGRect
    
    init(destinationFrame: CGRect) {
        self.destinationFrame = destinationFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        snapshot.layer.masksToBounds = true
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, at: 0)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransform(for: containerView)
        toVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    snapshot.frame = self.destinationFrame
                }
                
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                }
        },
            completion: { _ in
                fromVC.view.isHidden = false
                snapshot.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

}
