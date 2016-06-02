#Demo App Example

Below is aquick example of the alignment logic setup in the demo app provided with the application, producing the following layout:


![alt tag](/SimulatorImage.png?raw=true width='375' height='667')


```

struct ViewControllerConfig {    
    static let SizeBigView              = CGSizeMake(140, 140)
    static let SizeSmallView            = CGSizeMake(40, 40)
    static let SizePickerView           = CGSizeMake(UIScreen.mainScreen().bounds.width, 220)
    static let SizeCodeLabel            = CGSizeMake(UIScreen.mainScreen().bounds.width - 60, 120)
    
    static let VerticalOffsetBigView    = CGFloat(80)
    static let VerticalOffsetPickerView = CGFloat(-10)
    static let VerticalOffsetCodeLabel  = CGFloat(-50)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        alignInterface()
    }
    
    func configureInterface() {
        view.addSubview(bigView)
        view.addSubview(smallView)
        view.addSubview(codeLabel)
        view.addSubview(pickerView)
    }
    
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
    
    ...................
    
            Views defined here
} 
    
```
