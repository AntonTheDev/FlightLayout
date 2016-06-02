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
    case Above          // Align vertically Above
    case Below          // Align vertically Below
    case Center         // Align center.y vertically
    case Top            // Align vertically to the top
    case Base           // Align vertically to the base
}

public enum HorizontalAlign {
    case Left           // Align horizontally to the Left
    case Right          // Align horizontally to the Right
    case Center         // Align center.y horizontally
    case RightEdge      // Align horizontally to the Right Edge
    case LeftEdge       // Align horizontally to the Left Edge
}


// MARK: - UIView Alignment Extension

extension UIView {
    
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
    func align(toFrame  frame            : CGRect? = nil,
               withSize size             : CGSize? = nil,
                        horizontal       : HorizontalAlign = .Center,
                        vertical         : VerticalAlign = .Center,
                        horizontalOffset : CGFloat = 0.0,
                        verticalOffset   : CGFloat = 0.0) {
        
        let newRect = rectAligned(toFrame            : frame,
                                  withSize           : size,
                                  horizontal         : horizontal,
                                  vertical           : vertical,
                                  horizontalOffset   : horizontalOffset,
                                  verticalOffset     : verticalOffset)
        
        if CGRectEqualToRect(self.frame, newRect) == false {
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
    func rectAligned(toFrame  frame            : CGRect?  = nil,
                     withSize size             : CGSize? = nil,
                              horizontal       : HorizontalAlign = .Center,
                              vertical         : VerticalAlign = .Center,
                              horizontalOffset : CGFloat = 0.0,
                              verticalOffset   : CGFloat = 0.0) -> CGRect {
        
        var referenceFrame = frame
        
        if let relativeFrame = frame {
            if CGRectEqualToRect(CGRectZero, relativeFrame) {
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
        
        return calculatedFrame
    }
}


// MARK: - Private Alignment Calculations Extension

extension UIView {
    
    /**
     Private Method. Calculates a horizontally aligned frame for the source frame relative to
     the destination frame
     */
    final private func alignedHorizontalOrigin(forRect sourceRect      : CGRect,
                                               relativeToRect toRect   : CGRect,
                                               withAlignment alignment : HorizontalAlign) -> CGFloat {
        
        var origin = sourceRect.origin.x
        
        switch (alignment) {
        case .Left:
            origin = toRect.origin.x - sourceRect.size.width;
        case .Right:
            origin = CGRectGetMaxX(toRect);
        case .Center:
            origin = toRect.origin.x + ((toRect.size.width - sourceRect.size.width) / 2.0);
        case .LeftEdge:
            origin = toRect.origin.x;
        case .RightEdge:
            origin = CGRectGetMaxX(toRect) - sourceRect.size.width;
        }
        
        return round(origin)
    }
    
    /**
     Private Method. Calculates a vertically aligned frame for the source frame relative to
     the destination frame
     */
    final private func alignedVerticalOrigin(forRect sourceRect      : CGRect,
                                             relativeToRect toRect   : CGRect,
                                             withAlignment alignment : VerticalAlign) -> CGFloat {
        var origin = sourceRect.origin.x
        
        switch (alignment) {
        case .Top:
            origin = toRect.origin.y
        case .Base:
            origin = CGRectGetMaxY(toRect) - sourceRect.size.height
        case .Center:
            origin = toRect.origin.y + ((toRect.size.height - sourceRect.size.height) / 2.0)
        case .Above:
            origin = toRect.origin.y - sourceRect.size.height
        case .Below:
            origin = CGRectGetMaxY(toRect)
        }
        
        return round(origin)
    }
}


// MARK: - CGRect Extension

extension CGRect {
    
    /**
     Returns the frame's center position
     
     - returns: center of the rect
     */
    func center() -> CGPoint {
        return CGPointMake(self.midX, self.midY)
    }
    
    /**
     Returns the bounds value, with a CGPointZero origin
     
     - returns: bounds for the rect
     */
    func bounds() -> CGRect {
        return CGRectMake(0, 0, self.midX, self.midY)
    }
}
