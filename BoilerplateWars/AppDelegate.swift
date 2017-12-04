//
//  AppDelegate.swift
//  BoilerplateWars
//
//  Created by Fran on 11/28/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        guard !isRunningTests() else {
            installEmptyWindow()
            return true
        }

        ServiceLocator.sharedInstance.currentWindow = window
        ServiceLocator.sharedInstance.rootNavigator.goToJoinRebellion()

        return true
    }

    private final func isRunningTests() -> Bool {
        return NSClassFromString("XCTest") != nil
    }

    private final func installEmptyWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        self.window = window
        ServiceLocator.sharedInstance.currentWindow = self.window
        UIApplication.shared.keyWindow?.rootViewController = window.rootViewController
        UIApplication.shared.keyWindow?.layer.speed = 500
    }
}

