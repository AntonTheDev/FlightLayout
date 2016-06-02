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




![alt tag](/Documentation/VerticalAlignment.png?raw=true)
![alt tag](/Documentation/HorizontalAlignment.png?raw=true)

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