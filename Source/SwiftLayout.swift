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

// MARK: - UIView Direct Alignment Extension

extension UIView {
    
    /**
     Aligns the view relative to another view's frame
     
     - parameter otherView:        the relative view to align against
     - parameter horizontal:       the relative horizontal alignment to the other view
     - parameter vertical:         the relative vertical alignment to the other view
     - parameter horizontalOffset: the horizontal offset to apply to the relative horizontal alignment
     - parameter verticalOffset:   the horizontal offset to apply to the relative vertical alignment
     */
    func alignToView(otherView          : UIView,
                     horizontal         : HorizontalAlign,
                     vertical           : VerticalAlign ,
                     horizontalOffset   : CGFloat = 0.0,
                     verticalOffset     : CGFloat = 0.0) {
        
        alignWithSize(bounds.size,
                      toFrame: otherView.frame,
                      horizontal: horizontal,
                      vertical: vertical,
                      horizontalOffset: horizontalOffset,
                      verticalOffset: verticalOffset)
    }
    
    
    /**
     Aligns the view relative to another frame
     
     - parameter otherFrame:       the relative frame to align against
     - parameter horizontal:       the relative horizontal alignment to the other view
     - parameter vertical:         the relative vertical alignment to the other view
     - parameter horizontalOffset: the horizontal offset to apply to the relative horizontal alignment
     - parameter verticalOffset:   the horizontal offset to apply to the relative vertical alignment
     */
    func alignToFrame(otherFrame       : CGRect,
                      horizontal       : HorizontalAlign,
                      vertical         : VerticalAlign,
                      horizontalOffset : CGFloat = 0.0,
                      verticalOffset   : CGFloat = 0.0) {
        
        alignWithSize(self.bounds.size,
                      toFrame: otherFrame,
                      horizontal: horizontal,
                      vertical: vertical,
                      horizontalOffset: horizontalOffset,
                      verticalOffset: verticalOffset)
    }
    
    
    /**
      Aligns the view relative to another frame, and applies the new size in one call.
      Sometimes, there is a need to set the frame twice, once for bounds, and onces for
      alignment within another view. Use this methods to apply a size and align the view
      in a single call
     
     - parameter newSize:          new size to apply to the fiew
     - parameter toFrame:          the relative frame to align against
     - parameter horizontal:       the relative horizontal alignment to the other view
     - parameter vertical:         the relative vertical alignment to the other view
     - parameter horizontalOffset: the horizontal offset to apply to the relative horizontal alignment
     - parameter verticalOffset:   the horizontal offset to apply to the relative vertical alignment
     */
    func alignWithSize(newSize          : CGSize,
                       toFrame          : CGRect,
                       horizontal       : HorizontalAlign,
                       vertical         : VerticalAlign,
                       horizontalOffset : CGFloat = 0.0,
                       verticalOffset   : CGFloat = 0.0) {
        
        let newRect = UIView.alignedRectFor(newSize,
                                         toFrame: toFrame,
                                         horizontal: horizontal,
                                         vertical: vertical,
                                         horizontalOffset: horizontalOffset,
                                         verticalOffset: verticalOffset)

        if CGRectEqualToRect(self.frame, newRect) == false {
            self.frame = newRect
        }
    }
}

// MARK: - Calculated Return Value Methods

extension UIView {
    
    /**
     Calculates and returns the frame with a new size relative to the toFrame passed in.
     This is a handy method in the case that you need to perform animations,
     and need the final frame calculated prior without updating it.
     
     - parameter newSize:          new size to for the calculated frame
     - parameter toFrame:          the relative frame to calculate and align against
     - parameter horizontal:       the relative horizontal alignment to the other frame
     - parameter vertical:         the relative vertical alignment to the other frame
     - parameter horizontalOffset: the horizontal offset to apply to the relative horizontal alignment
     - parameter verticalOffset:   the horizontal offset to apply to the relative vertical alignment
     
     - returns: returns the final aligned frame
     */
    class func alignedRectFor(newSize          : CGSize,
                              toFrame          : CGRect,
                              horizontal       : HorizontalAlign,
                              vertical         : VerticalAlign,
                              horizontalOffset : CGFloat = 0.0,
                              verticalOffset   : CGFloat = 0.0) -> CGRect {
        
        var newRect =  CGRectMake(0,0, newSize.width, newSize.height)
        
        newRect.origin.x = alignedHorizontalOriginWithFrame(newRect, dest:toFrame, align : horizontal) + horizontalOffset
        newRect.origin.y = alignedVerticalOriginWithFrame(newRect, dest:toFrame, align :  vertical) + verticalOffset
        
        return newRect
    }
    
    
    /**
     Calculates and returns a new center point relative to the toFrame passed in.
     
     - parameter newSize:          new size to for the calculated bounds
     - parameter toFrame:          the relative frame to calculate and align against
     - parameter horizontal:       the relative horizontal alignment to the other frame
     - parameter vertical:         the relative vertical alignment to the other frame
     - parameter horizontalOffset: the horizontal offset to apply to the relative horizontal alignment
     - parameter verticalOffset:   the horizontal offset to apply to the relative vertical alignment
     
     - returns: center point for the newly calculated frame
     */
    class func alignedPositionFor(newSize          : CGSize,
                                  toFrame          : CGRect,
                                  horizontal       : HorizontalAlign,
                                  vertical         : VerticalAlign,
                                  horizontalOffset : CGFloat = 0.0,
                                  verticalOffset   : CGFloat = 0.0) -> CGPoint {
        
        let newRect =  UIView.alignedRectFor(newSize,
                                             toFrame          : toFrame,
                                             horizontal       : horizontal,
                                             vertical         : vertical,
                                             horizontalOffset : horizontalOffset,
                                             verticalOffset   : verticalOffset)
        
        return newRect.center()
    }
}


// MARK: - Calculation Logic Extension

/**
 Calculates a horizontally aligned frame for the source frame relative to
 the destination frame
 
 - parameter source : source frame
 - parameter dest   : destination frame
 - parameter align  : horizontal alignment to adjust the source frame by
 
 - returns          : horizontally aligned frame relative to the destination frame
 */
func alignedHorizontalOriginWithFrame(source : CGRect,  dest : CGRect, align : HorizontalAlign) -> CGFloat {
    var origin = source.origin.x
    
    switch (align) {
    case .Left:
        origin = dest.origin.x - source.size.width;
    case .Right:
        origin = CGRectGetMaxX(dest);
    case .Center:
        origin = dest.origin.x + ((dest.size.width - source.size.width) / 2.0);
    case .LeftEdge:
        origin = dest.origin.x;
    case .RightEdge:
        origin = CGRectGetMaxX(dest) - source.size.width;
    }
    return round(origin)
}


/**
 Calculates a vertically aligned frame for the source frame relative to
 the destination frame
 
 - parameter source : source frame
 - parameter dest   : destination frame
 - parameter align  : vertically alignment to adjust the source frame by
 
 - returns          : vertically aligned frame relative to the destination frame
 */
func alignedVerticalOriginWithFrame(source : CGRect,  dest : CGRect, align : VerticalAlign) -> CGFloat {
    var origin = source.origin.x
    
    switch (align) {
    case .Top:
        origin = dest.origin.y
    case .Base:
        origin = CGRectGetMaxY(dest) - source.size.height
    case .Center:
        origin = dest.origin.y + ((dest.size.height - source.size.height) / 2.0)
    case .Above:
        origin = dest.origin.y - source.size.height
    case .Below:
        origin = CGRectGetMaxY(dest)
    }
    return round(origin)
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

