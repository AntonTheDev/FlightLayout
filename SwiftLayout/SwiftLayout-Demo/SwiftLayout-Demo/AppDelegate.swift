//
//  AppDelegate.swift
//  SwiftLayout-Demo
//
//  Created by Anton Doudarev on 5/26/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var baseViewController: ViewController = ViewController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = self.baseViewController
        window?.makeKeyAndVisible()
        return true
    }
}

