//
//  AnimationHelper.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/6/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransform(for containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}
