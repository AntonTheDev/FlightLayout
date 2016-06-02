//
//  ViewController.swift
//  TestView
//
//  Created by Anton Doudarev on 5/26/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let progressView = CircleProgressView(frame:CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200))

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.frame = CGRectMake(0, 300, 200, 100)
        button.backgroundColor = UIColor.yellowColor()
        button.addTarget(self, action: #selector(ViewController.tap), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        view.addSubview(progressView)
   }
    
    func tap() {
        if  progressView.progress == 0.5 {
            progressView.progress = 1.0
        } else {
            progressView.progress = 0.5
        }
    }
}

class CircleProgressView: UIView {
    
    dynamic var progress: CGFloat = 0.00 {
        didSet {
            let animation = CABasicAnimation()
            animation.keyPath = "progress"
            animation.fromValue = circleLayer().progress
            animation.toValue = progress
            animation.duration = Double(0.5)
            self.layer.addAnimation(animation, forKey: "progress")
            circleLayer().progress = progress
        }
    }
    
    func circleLayer() ->  CircleProgressLayer {
        return self.layer as! CircleProgressLayer
    }

    override class func layerClass() -> AnyClass {
        return CircleProgressLayer.self
    }
}

class CircleProgressLayer: CALayer {
    @NSManaged var progress: CGFloat
    
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        progress = 1.0
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func needsDisplayForKey(key: String) -> Bool {
        if key == "progress" {
            return true
        }
        return super.needsDisplayForKey(key)
    }
    
    var backFillColor: UIColor = UIColor.blueColor()
    var fillColor: UIColor = UIColor.greenColor()
    var strokeColor: UIColor = UIColor.greenColor()
    var distToDestination: CGFloat = 10.0
    var arcWidth: CGFloat = 20
    var outlineWidth: CGFloat = 5
    
    override func drawInContext(ctx: CGContext) {
        super.drawInContext(ctx)
        
        UIGraphicsPushContext(ctx)

        //Drawing in the container
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height) - 10
        let startAngle: CGFloat = 3 * CGFloat(M_PI) / 2
        let endAngle: CGFloat = 3 * CGFloat(M_PI) / 2 + 2 * CGFloat(M_PI)
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        backFillColor.setStroke()
        path.stroke()
        let fill = UIColor.blueColor().colorWithAlphaComponent(0.15)
        fill.setFill()
        path.fill()
        
        //Drawing the fill path. Same process
        let fillAngleLength =  (CGFloat(M_PI)) * progress
        let fillStartAngle = 3 * CGFloat(M_PI) / 2 - fillAngleLength
        let fillEndAngle = 3 * CGFloat(M_PI) / 2 + fillAngleLength
        
        let fillPath_fill = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: fillStartAngle, endAngle: fillEndAngle, clockwise: true)
        fillPath_fill.lineWidth = arcWidth
        fillColor.setStroke()
        fillPath_fill.stroke()
        
        //Drawing container outline on top
        let outlinePath_outer = UIBezierPath(arcCenter: center, radius: radius / 2 - outlineWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let outlinePath_inner = UIBezierPath(arcCenter: center, radius: radius / 2 - arcWidth + outlineWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        outlinePath_outer.lineWidth = outlineWidth
        outlinePath_inner.lineWidth = outlineWidth
        strokeColor.setStroke()
        outlinePath_outer.stroke()
        outlinePath_inner.stroke()
        
        UIGraphicsPopContext()
    }
}




