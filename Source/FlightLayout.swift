//
//  SwiftLayout.swift
//  SwiftLayout
//
//  Created by Anton Doudarev on 5/25/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation
import UIKit

public enum VerticalAlign {
    case above          // Align vertically Above
    case below          // Align vertically Below
    case center         // Align center.y vertically
    case top            // Align vertically to the top
    case base           // Align vertically to the base
}

public enum HorizontalAlign {
    case left           // Align horizontally to the Left
    case right          // Align horizontally to the Right
    case center         // Align center.y horizontally
    case rightEdge      // Align horizontally to the Right Edge
    case leftEdge       // Align horizontally to the Left Edge
}


// MARK: - UIView Alignment Extension

public extension UIView {
    
    /**
     Align self relative to another frame.
     
     This method calculate a new frame based on the alignment
     parameters, and sets that frame on self
     
     - parameter toFrame:          relative frame to align against. If not assigned, will attempt to use the superview, else defaults to CGRectZero
     - parameter withSize:         size to set on the calculated frame, defaults to self.bounds.size
     - parameter horizontal:       horizontal alignment relative to the toView
     - parameter vertical:         vertical alignment relative to the toView
     - parameter horizontalOffset: horizontal offset to apply to the calculated relative frame, defautls to 0
     - parameter verticalOffset:   vertical offset to apply to the calculated relative frame, defautls to 0
     */
    public func align(toFrame frame   : CGRect? = nil,
                      withSize size    : CGSize? = nil,
                      horizontal       : HorizontalAlign = .center,
                      vertical         : VerticalAlign = .center,
                      horizontalOffset : CGFloat = 0.0,
                      verticalOffset   : CGFloat = 0.0) {
        
        let newRect = alignedRect(toFrame            : frame,
                                  withSize           : size,
                                  horizontal         : horizontal,
                                  vertical           : vertical,
                                  horizontalOffset   : horizontalOffset,
                                  verticalOffset     : verticalOffset)
        
        if self.frame.equalTo(newRect) == false {
            self.frame = newRect
        }
    }
    
    /**
     Calculates,vand returns a frame based on the alignment parameters.
     
     This is a handy method to use when performing animations, you can ask the view to return
     the frame it would align to without aligning it self to the returned value.
     
     See the CGRect Extension provided with this framework, you can query a CGRect
     for it's bounds and center. Since the frame property is not animatable, you
     may cancreate an animation group with two separate animations, one for position,
     and one for hte bounds
     
     - parameter toFrame:          relative frame to align against. If not assigned, will attempt to use the superview, else defaults to CGRectZero
     - parameter withSize:         size to set on the calculated frame, defaults to self.bounds.size
     - parameter horizontal:       horizontal alignment relative to the toView
     - parameter vertical:         vertical alignment relative to the toView
     - parameter horizontalOffset: horizontal offset to apply to the calculated relative frame, defautls to 0
     - parameter verticalOffset:   vertical offset to apply to the calculated relative frame, defautls to 0
     
     - returns: returns the final aligned frame
     */
    func alignedRect(toFrame frame    : CGRect?  = nil,
                     withSize size    : CGSize? = nil,
                     horizontal       : HorizontalAlign = .center,
                     vertical         : VerticalAlign = .center,
                     horizontalOffset : CGFloat = 0.0,
                     verticalOffset   : CGFloat = 0.0) -> CGRect {
        
        var referenceFrame = frame
        
        if let relativeFrame = frame {
            if CGRect.zero.equalTo(relativeFrame) {
                if let superviewFrame = superview?.bounds {
                    referenceFrame = superviewFrame
                }
            }
        } else {
            if let superviewFrame = superview?.bounds {
                referenceFrame = superviewFrame
            }
        }
        
        var calculatedFrame = self.bounds
        
        if let newSize = size {
            calculatedFrame.size = newSize
        }
        
        calculatedFrame.origin.x = alignedHorizontalOrigin(forRect          : calculatedFrame,
                                                           relativeToRect   : referenceFrame!,
                                                           withAlignment    : horizontal)
        
        calculatedFrame.origin.y = alignedVerticalOrigin(forRect        : calculatedFrame,
                                                         relativeToRect : referenceFrame!,
                                                         withAlignment  : vertical)
        
        calculatedFrame.origin.x += horizontalOffset
        calculatedFrame.origin.y += verticalOffset
        
        return calculatedFrame.integral
    }
}


// MARK: - Private Alignment Calculations Extension

extension UIView {
    
    /**
     Private Method. Calculates a horizontally aligned frame for the source frame relative to
     the destination frame
     */
    final fileprivate func alignedHorizontalOrigin(forRect sourceRect      : CGRect,
                                                   relativeToRect toRect   : CGRect,
                                                   withAlignment alignment : HorizontalAlign) -> CGFloat {
        
        var origin = sourceRect.origin.x
        
        switch (alignment) {
        case .left:
            origin = toRect.origin.x - sourceRect.size.width;
        case .right:
            origin = toRect.maxX;
        case .center:
            origin = toRect.origin.x + ((toRect.size.width - sourceRect.size.width) / 2.0);
        case .leftEdge:
            origin = toRect.origin.x;
        case .rightEdge:
            origin = toRect.maxX - sourceRect.size.width;
        }
        
        return round(origin)
    }
    
    /**
     Private Method. Calculates a vertically aligned frame for the source frame relative to
     the destination frame
     */
    final fileprivate func alignedVerticalOrigin(forRect sourceRect  : CGRect,
                                                 relativeToRect toRect   : CGRect,
                                                 withAlignment alignment : VerticalAlign) -> CGFloat {
        var origin = sourceRect.origin.x
        
        switch (alignment) {
        case .top:
            origin = toRect.origin.y
        case .base:
            origin = toRect.maxY - sourceRect.size.height
        case .center:
            origin = toRect.origin.y + ((toRect.size.height - sourceRect.size.height) / 2.0)
        case .above:
            origin = toRect.origin.y - sourceRect.size.height
        case .below:
            origin = toRect.maxY
        }
        
        return round(origin)
    }
}
