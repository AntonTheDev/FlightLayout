//
//  ViewController.swift
//  SwiftLayout-Demo
//
//  Created by Anton Doudarev on 5/26/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import UIKit

struct ViewControllerConfig {
    
    //MARK: - Picker Configuration
    static let HorizontalAlignmentStrings   = [".Left",".LeftEdge",".Center",".RightEdge",".Right"]
    static let VerticalAlignmentStrings     = [".Above",".Top",".Center",".Base",".Below"]
    static let OffsetRange                  = 60
    
    //MARK: - Color Configuration
    static let ColorViewBackground      = UIColor(red: 0.8157, green: 0.8157, blue: 0.8157, alpha: 1.0)
    static let ColorBigView             = UIColor(red: 0.1647, green: 0.0, blue: 0.7255, alpha: 1.0)
    static let ColorSmallView           = UIColor(red: 0.8504, green: 0.9679, blue: 0.0, alpha: 1.0)
   
    static let ColorCodeGreen           = UIColor(red: 0.149, green: 0.2784, blue: 0.2941, alpha: 1.0)
    static let ColorCodePurple          = UIColor(red: 0.3569, green: 0.149, blue: 0.6, alpha: 1.0)
    static let ColorCodeBlue            = UIColor(red: 0.1098, green: 0.0039, blue: 0.8078, alpha: 1.0)
    
    
    //MARK: - Size Configuration
    static let SizeBigView              = CGSizeMake(140, 140)
    static let SizeSmallView            = CGSizeMake(40, 40)
    static let SizePickerView           = CGSizeMake(UIScreen.mainScreen().bounds.width, 220)
    static let SizeCodeLabel            = CGSizeMake(UIScreen.mainScreen().bounds.width - 60, 120)
    
    //MARK: - Alignment Offset Configuration
    static let VerticalOffsetBigView    = CGFloat(80)
    static let VerticalOffsetPickerView = CGFloat(-10)
    static let VerticalOffsetCodeLabel  = CGFloat(-50)
}

//MARK: - Main View Controller

class ViewController: UIViewController {

    // Offset Range Value Arrays by the pickers
    // to the set the horizontal and vertical values
    var verticalValueArray = [Int]()
    var horizontalValueArray = [Int]()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInterface()
        configureData()
        alignInterface()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureCodeString()
    }
    
    // MARK: - Bootstrap View Controller
    
    /**
     Configures the picker data
     */
    
    func configureData() {
        for x in -ViewControllerConfig.OffsetRange...ViewControllerConfig.OffsetRange {
            verticalValueArray.append(x)
            horizontalValueArray.append(x)
        }
        
        pickerView.selectRow(ViewControllerConfig.OffsetRange, inComponent: 0, animated: false)
        pickerView.selectRow(ViewControllerConfig.OffsetRange, inComponent: 3, animated: false)
        pickerView.selectRow(2, inComponent: 1, animated: false)
        pickerView.selectRow(2, inComponent: 2, animated: false)
    }
    
    /**
     Configures the interface for display
     */
    func configureInterface() {
        view.backgroundColor = ViewControllerConfig.ColorViewBackground
        
        view.addSubview(bigView)
        view.addSubview(smallView)
        view.addSubview(codeLabel)
        view.addSubview(pickerView)
    }
    
    /**
     Aligns the interface using SwiftLayout
     */
    func alignInterface() {
        bigView.align(withSize          : ViewControllerConfig.SizeBigView,
                      vertical          : .Top,
                      verticalOffset    : ViewControllerConfig.VerticalOffsetBigView)
        
        smallView.align(toFrame         : bigView.frame,
                        withSize        : ViewControllerConfig.SizeSmallView)
        
        pickerView.align(withSize       : ViewControllerConfig.SizePickerView,
                         vertical       : .Base,
                         verticalOffset : ViewControllerConfig.VerticalOffsetPickerView)
        
        codeLabel.align(toFrame         : pickerView.frame,
                        withSize        : ViewControllerConfig.SizeCodeLabel,
                        vertical        : .Above,
                        verticalOffset  : ViewControllerConfig.VerticalOffsetCodeLabel)
    }
    
    // MARK: - Lazy Loaded Views
    
    lazy var bigView: UIView = {
        var view = UIView(frame : CGRectZero)
        view.alpha = 1.0
        view.backgroundColor = ViewControllerConfig.ColorBigView
        return view
    }()
    
    lazy var smallView: UIView = {
        var view = UIView(frame : CGRectZero)
        view.alpha = 1.0
        view.backgroundColor = ViewControllerConfig.ColorSmallView
        return view
    }()
    
    lazy var pickerView : UIPickerView = {
        var picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = UIColor.clearColor()
        return picker
    }()
    
    lazy var codeLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.cornerRadius = 8.0
        label.lineBreakMode = .ByWordWrapping
        label.backgroundColor = UIColor.whiteColor()
        label.textColor = UIColor.blackColor()
        return label
    }()
}


// MARK: - Interface Update Logic

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
    
    func configureCodeString() {
        
        var string = "\n   smallView.align(toFrame    : bigView.frame, "
        string += "\n                   withSize   : CGSizeMake(40, 40),"
        string += "\n                   horizontal : \(ViewControllerConfig.HorizontalAlignmentStrings[pickerView.selectedRowInComponent(1)]), "
        string += "\n                   vertical   : \(ViewControllerConfig.VerticalAlignmentStrings[pickerView.selectedRowInComponent(2)])"
        
        var extralines = 0
        
        if self.verticalValueArray[pickerView.selectedRowInComponent(0)]  != 0 {
            string += ","
            string += "\n                   horizontalOffset : \(self.horizontalValueArray[pickerView.selectedRowInComponent(0)]).0"
        } else {
            extralines += 1
        }
        
        if self.verticalValueArray[pickerView.selectedRowInComponent(3)]  != 0  {
            string += ","
            string += "\n                   verticalOffset   : \(self.verticalValueArray[pickerView.selectedRowInComponent(3)]).0"
        } else {
            extralines += 1
        }
        
        string += ")"
        
        for _ in 0...extralines {
            string += "\n"
        }
        
        var attributes = Dictionary<String , AnyObject>()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Left
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        attributes[NSFontAttributeName] = UIFont(name: "Menlo-Regular", size: 11)

        
        let attributedString =  NSMutableAttributedString(string: string)
        attributedString.setAttributes(attributes, range: NSMakeRange(0, attributedString.length))
        
        attributes[NSForegroundColorAttributeName] = ViewControllerConfig.ColorCodeGreen
        
        let startRange = (string as NSString).rangeOfString("smallView.align")
        let bigViewRange = (string as NSString).rangeOfString("bigView")
        
        attributedString.setAttributes(attributes, range: startRange)
        attributedString.setAttributes(attributes, range: bigViewRange)

        
        // Horizontal Color Ranges
        let leftRange = (string as NSString).rangeOfString(".Left")
        let leftEdgeRange = (string as NSString).rangeOfString(".LeftEdge")
        let rightEdgeRange = (string as NSString).rangeOfString(".RightEdge")
        let rightRange = (string as NSString).rangeOfString(".Right")
        
        // Vertical Color Ranges
        let topRange = (string as NSString).rangeOfString(".Top")
        let baseRange = (string as NSString).rangeOfString(".Base")
        let belowRange = (string as NSString).rangeOfString(".Below")
        let aboveRange = (string as NSString).rangeOfString(".Above")
       
        // Shared Center Ranges
        let centerRange = (string as NSString).rangeOfString(".Center")
        
        // Horizontal Attributes
        attributedString.setAttributes(attributes, range: rightEdgeRange)
        attributedString.setAttributes(attributes, range: leftEdgeRange)
        attributedString.setAttributes(attributes, range: centerRange)
        attributedString.setAttributes(attributes, range: rightRange)
        attributedString.setAttributes(attributes, range: leftRange)
        
        // Vertical Attributes
        attributedString.setAttributes(attributes, range: topRange)
        attributedString.setAttributes(attributes, range: baseRange)
        attributedString.setAttributes(attributes, range: belowRange)
        attributedString.setAttributes(attributes, range: aboveRange)

        attributes[NSForegroundColorAttributeName] = ViewControllerConfig.ColorCodePurple
        
        let frameRange = (string as NSString).rangeOfString("frame")
        let sizeRange = (string as NSString).rangeOfString("CGSizeMake")

        attributedString.setAttributes(attributes, range: frameRange)
        attributedString.setAttributes(attributes, range: sizeRange)
    
        attributes[NSForegroundColorAttributeName] = ViewControllerConfig.ColorCodeBlue
        
        self.codeLabel.attributedText = attributedString
    }
    
    func updateSmallView(horizontalAlingment : String, verticalAlingment : String, horizontalOffset : Int, verticalOffset : Int) {
       
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.smallView.align(toFrame:  self.bigView.frame,
                                 withSize: ViewControllerConfig.SizeSmallView,
                                 horizontal:  self.horizontalTypeForString(horizontalAlingment),
                                 vertical:  self.verticalTypeForString(verticalAlingment),
                                 horizontalOffset: CGFloat(horizontalOffset),
                                 verticalOffset : CGFloat(verticalOffset))
        }) { (complete) in
        }
        
        configureCodeString()
    }
}


// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return horizontalValueArray.count
        case 1:
            return ViewControllerConfig.HorizontalAlignmentStrings.count
        case 2:
            return ViewControllerConfig.VerticalAlignmentStrings.count
        default:
            return verticalValueArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        switch component {
        case 0:
            return  attriburedString("\(horizontalValueArray[row])", alignment : .Center)
        case 1:
            return  attriburedString(ViewControllerConfig.HorizontalAlignmentStrings[row], alignment : .Center)
        case 2:
            return  attriburedString(ViewControllerConfig.VerticalAlignmentStrings[row], alignment : .Center)
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
        updateSmallView(ViewControllerConfig.HorizontalAlignmentStrings[pickerView.selectedRowInComponent(1)],
                        verticalAlingment : ViewControllerConfig.VerticalAlignmentStrings[pickerView.selectedRowInComponent(2)],
                        horizontalOffset: pickerView.selectedRowInComponent(0) - ViewControllerConfig.OffsetRange ,
                        verticalOffset: pickerView.selectedRowInComponent(3) - ViewControllerConfig.OffsetRange)
    }
}

func attriburedString(copyString: String, alignment : NSTextAlignment = .Left) -> NSMutableAttributedString {
    var attributes = Dictionary<String , AnyObject>()
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
    attributes[NSParagraphStyleAttributeName] = paragraphStyle
    attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
    attributes[NSFontAttributeName] = UIFont(name: "Menlo-Regular", size: 11)
    
    let attributedString =  NSMutableAttributedString(string: copyString)
    attributedString.setAttributes(attributes, range: NSMakeRange(0, attributedString.length))
    
    return attributedString
}

