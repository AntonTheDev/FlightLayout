# Demo App Example

Below is a quick example of the alignment logic setup in the demo app provided with the application, producing the following layout:

<p align="center">
<img align="center"  src="https://github.com/AntonTheDev/SwiftLayout/blob/master/Documentation/SimulatorImage.png?raw=true" width="375" height="667" />
</p>

```

struct ViewControllerConfig {    
    static let SizeBigView              = CGSize(width: 140, height: 140)
    static let SizeSmallView            = CGSize(width : 40, height : 40)
    static let SizePickerView           = CGSize(UIScreen.main.bounds.width, 220)
    static let SizeCodeLabel            = CGSize(UIScreen.main.bounds.width - 60, 120)
    
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
    
    ...................
    
            Views defined here
} 
    
```
