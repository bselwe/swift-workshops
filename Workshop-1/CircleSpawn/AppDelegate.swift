//
//  AppDelegate.swift
//  CircleSpawn
//
//  Created by Bartosz Selwesiuk on 12/03/2019.
//  Copyright © 2019 Bartosz Selwesiuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        viewController.view.backgroundColor = UIColor.white
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
        return true
    }
}
