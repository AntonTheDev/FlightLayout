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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = self.baseViewController
        window?.makeKeyAndVisible()
        return true
    }
}

