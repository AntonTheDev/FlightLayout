# SwiftLayout

[![Cocoapods Compatible](https://img.shields.io/badge/pod-v0.1.0-blue.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]()
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![License](https://img.shields.io/badge/license-MIT-343434.svg)]()

##Introduction

SwiftLayout is a simple layout framework intended to be light weight, and easily readable, which a concise approach to laying out user interface elements. Functionally, it lives somewhere in between the manual process of laying out views from the old days, and the flexibility of Autolayout's dynamic contstraint approach.

Some use cases for this framework include the ability to animate views with core animation. Without the overhead of Autolayout's constraints system, we are free to apply parametric easing to layer properties with out having to ensure that constraints are created, updated, or remade at any point of the animation.


##Instalation

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

The installation instruction below are a for OSX and iOS, follow the extra steps documented when installing for iOS.

#####Installation

1. Create/Update the Cartfile with with the following
	
	```
#SwiftLayout
git "https://github.com/AntonTheDev/SwiftLayout.git"
	```
2. Run `carthage update`. This will fetch dependencies into a [Carthage/Checkouts][] folder, then build each one.
3. In the application targets’ “General” settings tab, in the “Embedded Binaries” section, drag and drop each framework for use from the Carthage/Build folder on disk.
4. Follow the installation instruction above. Once complete, perform the following steps
(If you have setup a carthage build task for iOS already skip to Step 5) 
5. Navigate to the targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

  	```
  	/usr/local/bin/carthage copy-frameworks
  	```
  	
6. Add the paths to the frameworks you want to use under “Input Files” within the carthage build phase as follows e.g.:

	```
 	$(SRCROOT)/Carthage/Build/iOS/SwiftLayout.framework
  	
  	```

##Basic Use

The framework is composed of two extensions. One extension on the UIView, the other on CGRect.

### UIView Extension

The `align` method allows you to align the view in question relatively to another with the flexible option of 6 paramaters, 4 of which are asigned default values, allowing a flexible method signature. See below for an indepth description of each parameter.
<br>


```
   func align(toFrame  frame             : CGRect = CGRectZero,  
               withSize size             : CGSize? = nil,        
                        horizontal       : HorizontalAlign,  
                        vertical         : VerticalAlign, 
                        horizontalOffset : CGFloat = 0.0, 
                        verticalOffset   : CGFloat = 0.0)
```

#### Horizontal & Vertical Alignment

There are two enumerators defined for horizontal and vertical alignment. There are the magic options that allow you to align a view relative to another frame.

##### Horizontal

The following are the horizontal options, with illustrations below

```
public enum HorizontalAlign {
    case Left           // Align horizontally to the Left
    case Right          // Align horizontally to the Right
    case Center         // Align center.y horizontally
    case RightEdge      // Align horizontally to the Right Edge
    case LeftEdge       // Align horizontally to the Left Edge
}

```

![alt tag](/Documentation/HorizontalAlignment.png?raw=true)

##### Vertical

The following are the vertical options, with illustrations below


```
public enum VerticalAlign {
    case Above          // Align vertically Above
    case Below          // Align vertically Below
    case Center         // Align center.y vertically
    case Top            // Align vertically to the top
    case Base           // Align vertically to the base
}

```

![alt tag](/Documentation/VerticalAlignment.png?raw=true)


##### Example 1

Assume you add a new view as a subview, and you want to align it dead center relative to the superview's bounds, it's as easy as the following.


```
   view.addSubview(bigView)

   bigView.align(toFrame    : view.bounds,     
   			     withSize   : CGSizeMake(140, 140),        
                 horizontal : .Center,  
                 vertical   : .Center)
```

##### Example 2

The above is the same as below. If the **toFrame** is ommitted, if it automatically assume that you are intending to align against the view's superview.

```
   view.addSubview(bigView)

   bigView.align(withSize   : CGSizeMake(140, 140),        
                 horizontal : .Center,  
                 vertical   : .Center)
```

##### Example 3

What if we implemented a sizeToFit method on our view, where it autoresizes itself. We can actually ommit the the **withSize** parameter from the method signature.

```
   view.addSubview(bigView)
   
   bigView.sizeToFit()
   bigView.align(horizontal : .Center,  
                 vertical   : .Center)
```

The horizontal alignment  


##### Horizontal & Vertical Offset


##### Precalculated Frame

. This is helpful when performing animations, and allows the developer to precalculate the frame.


```
   func rectAligned(toFrame  frame            : CGRect  = CGRectZero,
                     withSize size             : CGSize? = nil,
                              horizontal       : HorizontalAlign,
                              vertical         : VerticalAlign,
                              horizontalOffset : CGFloat = 0.0,
                              verticalOffset   : CGFloat = 0.0) -> CGRect

```


#### CGREct Extension





## License

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