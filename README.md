# SwiftLayout

[![Cocoapods Compatible](https://img.shields.io/badge/pod-v0.7.0-blue.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]()
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![License](https://img.shields.io/badge/license-MIT-343434.svg)]()

## Introduction

SwiftLayout is a light weight, and easily layout framework as an extension of the UIView. Functionally, it lives somewhere in between the manual process of laying out views from the old days, and the flexibility of Autolayout's dynamic contstraint approach.

Some use cases for this framework include the ability to animate views with core animation. Without the overhead of Autolayout's constraints system, we are free to apply animations without hte hasstle of disabling constraints to perform parametric animations to a layer's properties.

## Demo

Since the scope of the documentation is limited to a handlful of examples, once you have finished with the reading the documentation below, feel free to clone the project and run the demo app with the project. 

The demo app provides the ability to pick different options in the method call, once selected, the app will align a demo view on the screen to it's final frame, and provide a code example to reflect it.

An example of how the view controller is layed out in the demo app is can be found [here](/Documentation/demo.md)

## Installation

* [Installation Documentation](/Documentation/installation.md)

## Basic Use

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
   func rectAligned(toFrame frame              : CGRect  = CGRectZero,
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
    case left           // Align horizontally to the Left
    case leftEdge       // Align horizontally to the Left Edge
    case center         // Align center.y horizontally
    case rightEdge      // Align horizontally to the Right Edge
    case right          // Align horizontally to the Right
}

```

![alt tag](/Documentation/HorizontalAlignment.png?raw=true)

### Vertical Alignment

The vertical options align the calling view on the vertical plane, with illustrations below


```
public enum VerticalAlign {
    case above          // Align vertically Above
    case top            // Align vertically to the top
    case center         // Align center.y vertically
    case base           // Align vertically to the base
    case below          // Align vertically Below
}

```

![alt tag](/Documentation/VerticalAlignment.png?raw=true)


##### Example 1

In the following example, first we add the a new view named **bigView** as a subview, and say you want to align it dead center relative to the superview's bounds. It's as calling align against the view with the following method. This call with align the big **bigView** against the view's bounds that it was added to, with a horizontal, and vertical, alignment of ``.Center``.


```
   view.addSubview(bigView)

   bigView.align(toFrame    : view.bounds,     
   			     withSize   : CGSize(width : 140.0, height : 140.0),        
                 horizontal : .center,  
                 vertical   : .center)
```

Note: In the case that the calculated frame is the same as the calling views frame, it will not actually set the frame on the caller, it will just exit. This helps avoid glitches during animations, i.e  setting the frame on the view that is currently animating, will flicker the view to it's final position.

##### Example 2

The call in Example 1 can also be expressed by ommitting **toFrame** parameter. In the absense of the **toFrame** parameter from the method call, the framework automatically assumes that you are intending to align the calling view against the it's superview's bounds.

```
   view.addSubview(bigView)

   bigView.align(withSize   : CGSize(width : 140.0, height : 140.0),        
                 horizontal : .center,  
                 vertical   : .center)
```

##### Example 3

What if we implemented a ``sizeToFit()`` method on our calling view.  In the absense of the **withSize** parameter from the method call, the framework automatically assumes that you are intending to use the current size of the calling view.

```
   view.addSubview(bigView)
   
   bigView.sizeToFit()
   bigView.align(horizontal : .center,  
                 vertical   : .center)
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
   bigView.align(horizontal : .center,  
                 vertical   : .center,
                 horizontalOffset : 20.0,
                 verticalOffset   : -20.0)
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
