//
//  HelperManager.swift
//  DynamicFlowLayout
//
//  Created by Shankar on 19/01/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import AVFoundation

public extension UIImage {
    /**
     Calculates the best height of the image for available width.
     */
    func height(forWidth width: CGFloat) -> CGFloat {
        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        let rect = AVMakeRect(
            aspectRatio: size,
            insideRect: boundingRect
        )
        return rect.size.height
    }
}
