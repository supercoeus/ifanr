//
//  AppDelegate.swift
//  ifanr
//
//  Created by dubinyuan on 16/6/29.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()

//        window?.rootViewController = HomeViewController()

//        window?.rootViewController = MainViewController()
//        window?.rootViewController = NewsFlashController()
//        window?.rootViewController = PlayingZhiController()
//        window?.rootViewController = AppSoViewController()
        window?.rootViewController = MindStoreViewController()

        return true
    }
}
