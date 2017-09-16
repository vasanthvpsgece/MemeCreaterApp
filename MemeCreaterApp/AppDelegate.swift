//
//  AppDelegate.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 8/6/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()
    var index: IndexPath?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

