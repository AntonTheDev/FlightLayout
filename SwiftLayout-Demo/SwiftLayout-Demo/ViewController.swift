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
    static let HorizontalAlignmentStrings   = [".left",".leftEdge",".center",".rightEdge",".right"]
    static let VerticalAlignmentStrings     = [".above",".top",".center",".base",".below"]
    static let OffsetRange                  = 60
    
    //MARK: - Color Configuration
    static let ColorViewBackground      = UIColor(red: 0.868627451, green: 0.868627451, blue: 0.868627451, alpha: 0.5)
    static let ColorBigView             = UIColor(red: 0.1647, green: 0.0, blue: 0.7255, alpha: 1.0)
    static let ColorSmallView           = UIColor(red: 0.8504, green: 0.9679, blue: 0.7255, alpha: 1.0)
   
    static let ColorCodeGreen           = UIColor(red: 0.149, green: 0.2784, blue: 0.2941, alpha: 1.0)
    static let ColorCodePurple          = UIColor(red: 0.3569, green: 0.149, blue: 0.6, alpha: 1.0)
    static let ColorCodeBlue            = UIColor(red: 0.1098, green: 0.0039, blue: 0.8078, alpha: 1.0)
    
    
    //MARK: - Size Configuration
    static let SizeBigView              = CGSize(width: 140, height: 140)
    static let SizeSmallView            = CGSize(width: 40, height: 40)
    static let SizePickerView           = CGSize(width: UIScreen.main.bounds.width, height: 220)
    static let SizeCodeLabel            = CGSize(width: UIScreen.main.bounds.width - 60, height: 120)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
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
                      vertical          : .top,
                      verticalOffset    : ViewControllerConfig.VerticalOffsetBigView)
        
        smallView.align(toFrame         : bigView.frame,
                        withSize        : ViewControllerConfig.SizeSmallView)
        
        pickerView.align(withSize       : ViewControllerConfig.SizePickerView,
                         vertical       : .base,
                         verticalOffset : ViewControllerConfig.VerticalOffsetPickerView)
        
        codeLabel.align(toFrame         : pickerView.frame,
                        withSize        : ViewControllerConfig.SizeCodeLabel,
                        vertical        : .above,
                        verticalOffset  : ViewControllerConfig.VerticalOffsetCodeLabel)
    }
    
    // MARK: - Lazy Loaded Views
    
    lazy var bigView: UIView = {
        var view = UIView(frame : CGRect.zero)
        view.alpha = 1.0
        view.backgroundColor = ViewControllerConfig.ColorBigView
        return view
    }()
    
    lazy var smallView: UIView = {
        var view = UIView(frame : CGRect.zero)
        view.alpha = 1.0
        view.backgroundColor = ViewControllerConfig.ColorSmallView
        return view
    }()
    
    lazy var pickerView : UIPickerView = {
        var picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = UIColor.clear
        return picker
    }()
    
    lazy var codeLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.cornerRadius = 8.0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        return label
    }()
}


// MARK: - Interface Update Logic

extension ViewController {
    
    func horizontalTypeForString(_ type : String) -> HorizontalAlign {
        switch type  {
        case ".left":
            return .left
        case ".leftEdge":
            return .leftEdge
        case ".right":
            return .right
        case ".rightEdge":
            return .rightEdge
        default:
            return .center
        }
    }
    
    func verticalTypeForString(_ type : String) -> VerticalAlign {
        switch type  {
        case ".above":
            return .above
        case ".top":
            return .top
        case ".base":
            return .base
        case ".below":
            return .below
        default:
            return .center
        }
    }
    
    func configureCodeString() {
  
        var string = "\n    var size = CGSize(width: 40, height : 40) "
        
        string += "\n\n    smallView.align(toFrame    : bigView.frame, "
        string += "\n                    withSize   : size,"
        string += "\n                    horizontal : \(ViewControllerConfig.HorizontalAlignmentStrings[pickerView.selectedRow(inComponent: 1)]), "
        string += "\n                    vertical   : \(ViewControllerConfig.VerticalAlignmentStrings[pickerView.selectedRow(inComponent: 2)])"
        
        var extralines = 0
        
        if self.verticalValueArray[pickerView.selectedRow(inComponent: 0)]  != 0 {
            string += ","
            string += "\n                    horizontalOffset : \(self.horizontalValueArray[pickerView.selectedRow(inComponent: 0)]).0"
        } else {
            extralines += 1
        }
        
        if self.verticalValueArray[pickerView.selectedRow(inComponent: 3)]  != 0  {
            string += ","
            string += "\n                    verticalOffset   : \(self.verticalValueArray[pickerView.selectedRow(inComponent: 3)]).0"
        } else {
            extralines += 1
        }
        
        string += ")"
        
        for _ in 0...extralines {
            string += "\n"
        }
        
        var attributes = Dictionary<String , AnyObject>()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        attributes[NSForegroundColorAttributeName] = UIColor.black
        attributes[NSFontAttributeName] = UIFont(name: "Menlo-Regular", size: 10)

        
        let attributedString =  NSMutableAttributedString(string: string)
        attributedString.setAttributes(attributes, range: NSMakeRange(0, attributedString.length))
        
        attributes[NSForegroundColorAttributeName] = ViewControllerConfig.ColorCodeGreen
        
        let startRange = (string as NSString).range(of: "smallView.align")
        let bigViewRange = (string as NSString).range(of: "bigView")
        
        attributedString.setAttributes(attributes, range: startRange)
        attributedString.setAttributes(attributes, range: bigViewRange)

        
        // Horizontal Color Ranges
        let leftRange = (string as NSString).range(of: ".left")
        let leftEdgeRange = (string as NSString).range(of: ".leftEdge")
        let rightEdgeRange = (string as NSString).range(of: ".rightEdge")
        let rightRange = (string as NSString).range(of: ".right")
        
        // Vertical Color Ranges
        let topRange = (string as NSString).range(of: ".top")
        let baseRange = (string as NSString).range(of: ".base")
        let belowRange = (string as NSString).range(of: ".below")
        let aboveRange = (string as NSString).range(of: ".above")
       
        // Shared Center Ranges
        let centerRange = (string as NSString).range(of: ".center")
        
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
        
        let frameRange = (string as NSString).range(of: "frame")
        let sizeRange = (string as NSString).range(of: "CGSize")
        let varRange = (string as NSString).range(of: "var")

        attributedString.setAttributes(attributes, range: frameRange)
        attributedString.setAttributes(attributes, range: sizeRange)
        attributedString.setAttributes(attributes, range: varRange)
        
        attributes[NSForegroundColorAttributeName] = ViewControllerConfig.ColorCodeBlue
        UIView.transition(with: self.codeLabel,
                                  duration: 0.26,
                                  options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                self.codeLabel.attributedText = attributedString
            }) { (complete) in
            
        }

    }
    
    func updateSmallView(_ horizontalAlingment : String, verticalAlingment : String, horizontalOffset : Int, verticalOffset : Int) {
       
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        switch component {
        case 0:
            return  attriburedString("\(horizontalValueArray[row])", alignment : .center)
        case 1:
            return  attriburedString(ViewControllerConfig.HorizontalAlignmentStrings[row], alignment : .center)
        case 2:
            return  attriburedString(ViewControllerConfig.VerticalAlignmentStrings[row], alignment : .center)
        default:
            return  attriburedString("\(verticalValueArray[row])", alignment : .center)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateSmallView(ViewControllerConfig.HorizontalAlignmentStrings[pickerView.selectedRow(inComponent: 1)],
                        verticalAlingment : ViewControllerConfig.VerticalAlignmentStrings[pickerView.selectedRow(inComponent: 2)],
                        horizontalOffset: pickerView.selectedRow(inComponent: 0) - ViewControllerConfig.OffsetRange ,
                        verticalOffset: pickerView.selectedRow(inComponent: 3) - ViewControllerConfig.OffsetRange)
    }
}

func attriburedString(_ copyString: String, alignment : NSTextAlignment = .left) -> NSMutableAttributedString {
    var attributes = Dictionary<String , AnyObject>()
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
    attributes[NSParagraphStyleAttributeName] = paragraphStyle
    attributes[NSForegroundColorAttributeName] = UIColor.black
    attributes[NSFontAttributeName] = UIFont(name: "Menlo-Regular", size: 10)
    
    let attributedString =  NSMutableAttributedString(string: copyString)
    attributedString.setAttributes(attributes, range: NSMakeRange(0, attributedString.length))
    
    return attributedString
}

