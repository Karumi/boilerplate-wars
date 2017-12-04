//
//  ServiceLocator.swift
//  BoilerplateWars
//
//  Created by Fran on 11/29/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import UIKit
import Foundation

class ServiceLocator {
    // To reduce the code required to do dependency injection, we are gonna
    // set a very basic service locator where the ViewControllers will be able
    // to satisfy their dependencies.

    static var sharedInstance = ServiceLocator()

    static func nuke() {
        let oldWindow = sharedInstance.currentWindow
        sharedInstance = ServiceLocator()
        sharedInstance.currentWindow = oldWindow
    }

    var currentWindow: UIWindow?

    lazy var rootNavigator: RootNavigator = RootNavigator(window: currentWindow!)

    lazy var joinRebellionViewController: JoinRebellionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "JoinRebellionViewController") as! JoinRebellionViewController
        controller.presenter = getJoinRebellionPresenter()
        return controller
    }()

    func getJoinRebellionPresenter() -> JoinRebellionPresenter {
        return JoinRebellionPresenter()
    }
}
