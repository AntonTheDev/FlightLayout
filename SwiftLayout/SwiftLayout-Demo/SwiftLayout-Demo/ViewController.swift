//
//  ViewController.swift
//  SwiftLayout-Demo
//
//  Created by Anton Doudarev on 5/26/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var horizontalArray = [".Left",".LeftEdge",".Center",".RightEdge",".Right"]
    var verticalArray = [".Above",".Top",".Center",".Base",".Below"]
    var verticalValueArray = [Int]()
    var horizontalValueArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bigView)
        view.addSubview(smallView)
        view.addSubview(codeLabel)
        view.addSubview(pickerView)
        view.backgroundColor = UIColor ( red: 0.148, green: 0.8849, blue: 0.5847, alpha: 1.0 )
        
        for x in -60...60 {
            verticalValueArray.append(x)
            horizontalValueArray.append(x)
        }
        
        pickerView.selectRow(60, inComponent: 0, animated: false)
        pickerView.selectRow(60, inComponent: 3, animated: false)
        pickerView.selectRow(2, inComponent: 1, animated: false)
        pickerView.selectRow(2, inComponent: 2, animated: false)
        
        alignViews()
        configureCodeString()

    }
    
    func configureCodeString() {
      
        var string = "  smallView.alignWithSize(CGSizeMake(40, 40),"
        string += "\n                          toFrame : bigView.frame, "
        string += "\n                          horizontal : \(self.horizontalArray[pickerView.selectedRowInComponent(1)]), "
        string += "\n                          vertical : \(self.verticalArray[pickerView.selectedRowInComponent(2)])"
        var extralines = 0
        if self.verticalValueArray[pickerView.selectedRowInComponent(0)]  != 0 {
            string += ","
            string += "\n                          horizontalOffset : \(self.verticalValueArray[pickerView.selectedRowInComponent(0)]).0"
        } else {
            extralines += 1
        }
        
        if self.verticalValueArray[pickerView.selectedRowInComponent(3)]  != 0  {
            string += ","
            string += "\n                          verticalOffset : \(self.verticalValueArray[pickerView.selectedRowInComponent(3)]).0"
        } else {
            extralines += 1
        }
        
        string += ")"
        
        for _ in 0...extralines {
             string += "\n"
        }
        
        UIView.transitionWithView(self.codeLabel, duration: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                self.codeLabel.attributedText = attriburedString(string)
            }) { (complete) in
                
        }
    }
    
    func alignViews() {
        bigView.alignWithSize(CGSizeMake(140, 140),
                              toFrame: view.frame,
                              horizontal: .Center,
                              vertical: .Top,
                              verticalOffset : 80)
        
        smallView.alignWithSize(CGSizeMake(40, 40),
                              toFrame: bigView.frame,
                              horizontal: .Center,
                              vertical: .Center)
        
        pickerView.alignWithSize(CGSizeMake(pickerView.bounds.size.width * 1.15, pickerView.bounds.size.height),
                                 toFrame: view.bounds,
                                 horizontal: .Center,
                                 vertical: .Base,
                                 verticalOffset :-10)
        
        codeLabel.alignWithSize(CGSizeMake(view.bounds.size.width - 40, 200),
                                 toFrame: pickerView.frame,
                                 horizontal: .Center,
                                 vertical: .Above,
                                 horizontalOffset:  0,
                                 verticalOffset :-20)
    }
    
    lazy var bigView: UIView = {
        var view = UIView(frame : CGRectZero)
        view.alpha = 1.0
        view.backgroundColor = UIColor ( red: 0.1647, green: 0.0, blue: 0.7255, alpha: 1.0 )
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.blackColor().CGColor
        return view
    }()
    
    lazy var smallView: UIView = {
        var view = UIView(frame : CGRectZero)
        view.alpha = 1.0
        view.backgroundColor = UIColor ( red: 0.8504, green: 0.9679, blue: 0.0, alpha: 1.0 )
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.blackColor().CGColor
        return view
    }()
    
    // MARK: - Lazy Loaded Views
    
    lazy var pickerView : UIPickerView = {
        var picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = UIColor.clearColor()
        return picker
    }()
    
    lazy var codeLabel : UILabel = {
        var picker = UILabel()
        picker.numberOfLines = 0
        picker.lineBreakMode = .ByWordWrapping
        picker.backgroundColor = UIColor.whiteColor()
        picker.textColor = UIColor.blackColor()
        return picker
    }()
}


extension ViewController {
    
    func horizontalTypeForString(type : String) -> HorizontalAlign {
        switch type  {
        case ".Left":
            return .Left
        case ".LeftEdge":
            return .LeftEdge
        case ".Right":
            return .Right
        case ".RightEdge":
            return .RightEdge
        default:
            return .Center
        }
    }
    
    func verticalTypeForString(type : String) -> VerticalAlign {
        switch type  {
        case ".Above":
            return .Above
        case ".Top":
            return .Top
        case ".Base":
            return .Base
        case ".Below":
            return .Below
        default:
            return .Center
        }
    }
    
    func updateSmallView(horizontalAlingment : String, verticalAlingment : String, horizontalOffset : Int, verticalOffset : Int) {
       
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.smallView.alignWithSize(CGSizeMake(40, 40),
                toFrame:  self.bigView.frame,
                horizontal:  self.horizontalTypeForString(horizontalAlingment),
                vertical:  self.verticalTypeForString(verticalAlingment),
                horizontalOffset: CGFloat(horizontalOffset),
                verticalOffset : CGFloat(verticalOffset))
            }) { (complete) in
        }
        
        configureCodeString()
    }
}


func attriburedString(copyString: String, alignment : NSTextAlignment = .Left) -> NSAttributedString {
    var attributes = Dictionary<String , AnyObject>()
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
  //  paragraphStyle.minimumLineHeight = 18
  //  paragraphStyle.maximumLineHeight = 18
    paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
    attributes[NSParagraphStyleAttributeName] = paragraphStyle
    attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
    attributes[NSFontAttributeName] = UIFont(name: "Menlo-Regular", size: 12)

    let attributedString =  NSMutableAttributedString(string: copyString)
    attributedString.setAttributes(attributes, range: NSMakeRange(0, attributedString.length))
    
    return attributedString
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return horizontalValueArray.count
        case 1:
            return horizontalArray.count
        case 2:
            return verticalArray.count
        default:
            return verticalValueArray.count
        }
    }
    /*
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return "\(horizontalValueArray[row])"
        case 1:
            return horizontalArray[row]
        case 2:
            return verticalArray[row]
        default:
            return "\(verticalValueArray[row])"
        }
    }
    */
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        switch component {
        case 0:
            return  attriburedString("\(horizontalValueArray[row])", alignment : .Center)
        case 1:
            return  attriburedString(horizontalArray[row], alignment : .Center)
        case 2:
            return  attriburedString(verticalArray[row], alignment : .Center)
        default:
            return  attriburedString("\(verticalValueArray[row])", alignment : .Center)
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 60
        case 1:
            return  110
        case 2:
            return  110
        default:
            return  60
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        updateSmallView(horizontalArray[pickerView.selectedRowInComponent(1)],
                        verticalAlingment : verticalArray[pickerView.selectedRowInComponent(2)],
                        horizontalOffset: pickerView.selectedRowInComponent(0) - 60 ,
                        verticalOffset: pickerView.selectedRowInComponent(3) - 60)
    }
}

