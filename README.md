# SwiftLayout

[![Cocoapods Compatible](https://img.shields.io/badge/pod-v0.5.0-blue.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]()
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![License](https://img.shields.io/badge/license-MIT-343434.svg)]()

##Introduction

SwiftLayout is a simple layout framework intended to be light weight, and easily readable, which a concise approach to laying out user interface elements. Functionally, it lives somewhere in between the manual process of laying out views from the old days, and the flexibility of Autolayout's dynamic contstraint approach.

Some use cases for this framework include the ability to animate views with core animation. Without the overhead of Autolayout's constraints system, we are free to apply parametric easing to layer properties with out having to ensure that constraints are created, updated, or remade at any point of the animation.

##Demo

Once you have finished with the documentation below, feel free to the play with the demo app provided as part of this project. Since the scope of the documentation is limited to a handlful of examples, the demo app provides you ability to pick the different options in the method call. Once selected, the app will align a demo view on the screen to it's final position, and provide a the code example to reflect it.


##Basic Use

The UIView Extension within the frame contains the `align` method, when called by a view, the calling view will set it's own frame relatively, as specified by the parameters in the method call . The method containts 6 optional paramaters with assigned defaults, thus creating very poweful and flexible method signature with lots of possibilities. See below for an indepth examples below for definitions of each parameter.

There are two enumerators defined for horizontal and vertical alignment. These are the magic options that allow you to align the calling view relative to another frame.

<br>


```   
   func align(toFrame  frame             : CGRect? = nil,
               withSize size             : CGSize? = nil,        
                        horizontal       : HorizontalAlign,  
                        vertical         : VerticalAlign, 
                        horizontalOffset : CGFloat = 0.0, 
                        verticalOffset   : CGFloat = 0.0)
```

When performing animations, there often comes a need to calculate the frame to perform an animation. The following method returns a precalculate the frame based on the method parameters included, without actuially setitng it on the callign view. The `align` method actually this to calculate it's final value.


```
   func rectAligned(toFrame  frame            : CGRect  = CGRectZero,
                     withSize size             : CGSize? = nil,
                              horizontal       : HorizontalAlign,
                              vertical         : VerticalAlign,
                              horizontalOffset : CGFloat = 0.0,
                              verticalOffset   : CGFloat = 0.0) -> CGRect

```

### Horizontal Alignment

The following horizontal options align the calling view on the horizontal plane, with illustrations below

```
public enum HorizontalAlign {
    case Left           // Align horizontally to the Left
    case LeftEdge       // Align horizontally to the Left Edge
    case Center         // Align center.y horizontally
    case RightEdge      // Align horizontally to the Right Edge
    case Right          // Align horizontally to the Right
}

```

![alt tag](/Documentation/HorizontalAlignment.png?raw=true)

### Vertical Alignment

The vertical options align the calling view on the vertical plane, with illustrations below


```
public enum VerticalAlign {
    case Above          // Align vertically Above
    case Top            // Align vertically to the top
    case Center         // Align center.y vertically
    case Base           // Align vertically to the base
    case Below          // Align vertically Below
}

```

![alt tag](/Documentation/VerticalAlignment.png?raw=true)


##### Example 1

In the following example, first we add the a new view named **bigView** as a subview, and say you want to align it dead center relative to the superview's bounds. It's as calling align against the view with the following method. This call with align the big **bigView** against the view's bounds that it was added to, with a horizontal, and vertical, alignment of ``.Center``.


```
   view.addSubview(bigView)

   bigView.align(toFrame    : view.bounds,     
   			     withSize   : CGSizeMake(140, 140),        
                 horizontal : .Center,  
                 vertical   : .Center)
```

Note: In the case that the calculated frame is the same as the calling views frame, it will not actually set the frame on the caller, it will just exit. This helps avoid glitches during animations, i.e  setting the frame on the view that is currently animating, will flicker the view to it's final position.

##### Example 2

The call in Example 1 can also be expressed by ommitting **toFrame** parameter. In the absense of the **toFrame** parameter from the method call, the framework automatically assumes that you are intending to align the calling view against the it's superview's bounds.

```
   view.addSubview(bigView)

   bigView.align(withSize   : CGSizeMake(140, 140),        
                 horizontal : .Center,  
                 vertical   : .Center)
```

##### Example 3

What if we implemented a ``sizeToFit()`` method on our calling view.  In the absense of the **withSize** parameter from the method call, the framework automatically assumes that you are intending to use the current size of the calling view.

```
   view.addSubview(bigView)
   
   bigView.sizeToFit()
   bigView.align(horizontal : .Center,  
                 vertical   : .Center)
```

###### Example 4

The above example, can also be expressed by ommitting **horizontal** and **vertical** parameters. In the absense of the **horizontal** and **vertical** parameters from the method call, the framework automatically assumes that you are intending to align the calling view's to the center horizontally, and vertically, by defaulting to ``.Center``.


```
   view.addSubview(bigView)
   
   bigView.sizeToFit()
   bigView.align()
   
```

### Horizontal & Vertical Offset

The **horizontalOffset** and **verticalOffset** parameters adjust the calling view's final frame on the **horizontal** and **vertical** alignment parameters. 

Lets assume we want to center the view and adjust it 20px right, and 20px upward. We can do this by including the **horizontalOffset** and **verticalOffset** and update the offset as follows.


```
   view.addSubview(bigView)
   
   bigView.sizeToFit()
   bigView.align(horizontal : .Center,  
                 vertical   : .Center,
                 horizontalOffset : CGFloat = 20.0,
                 verticalOffset   : CGFloat = -20.0)
```

##Demo App Example

Below is a quick example of the alignment logic to setup the demo app, producing the following layout:


![alt tag](/Documentation/SimulatorImage.png?raw=true width='375' height='667')


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


##Installation

####Manual Install

1. Clone the [SwiftLayout](git@github.com:AntonTheDev/SwiftLayout.git) repository 
2. Add the contents of the Source Directory to the project

####CocoaPods

1. Edit the project's podfile, and save

	```
    pod 'SwiftLayout', :git => 'https://github.com/AntonTheDev/SwiftLayout.git' 
	```
2. Install SwiftLayout by running

    ```
    pod install
    ```
    
####Carthage

The installation instruction below a OSX for iOS.

#####Installation

1. Create/Update the Cartfile with with the following
	
	```
#SwiftLayout
git "https://github.com/AntonTheDev/SwiftLayout.git"
	```
2. Run `carthage update`. This will fetch dependencies into a [Carthage/Checkouts][] folder, then build each one.
3. In the application targets’ “General” settings tab, in the “Embedded Binaries” section, drag and drop each framework for use from the Carthage/Build folder on disk.
4. Follow the installation instruction above. Once complete, perform the following steps
(If you have setup a carthage build task for iOS already skip to Step 6) 
5. Navigate to the targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

  	```
  	/usr/local/bin/carthage copy-frameworks
  	```
  	
6. Add the paths to the frameworks you want to use under “Input Files” within the carthage build phase as follows e.g.:

	```
 	$(SRCROOT)/Carthage/Build/iOS/SwiftLayout.framework
  	
  	```


## License
<br>

     The MIT License (MIT)  
      
     Copyright (c) 2016 Anton Doudarev  
      
     Permission is hereby granted, free of charge, to any person obtaining a copy
     of this software and associated documentation files (the "Software"), to deal
     in the Software without restriction, including without limitation the rights
     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     copies of the Software, and to permit persons to whom the Software is
     furnished to do so, subject to the following conditions:  
     
     The above copyright notice and this permission notice shall be included in all
     copies or substantial portions of the Software.  
      
     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
     SOFTWARE.  