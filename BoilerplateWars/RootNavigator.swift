//
//  RootNavigator.swift
//  BoilerplateWars
//
//  Created by Fran on 12/4/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import Foundation
import UIKit

class RootNavigator {
    private let window: UIWindow

    internal var navigationController: UINavigationController! {
        return window.rootViewController as! UINavigationController
    }

    init(window: UIWindow) {
        self.window = window
        window.rootViewController = UINavigationController()
    }

    func goToJoinRebellion() {
        window.rootViewController = UINavigationController()
        navigationController.pushViewController(ServiceLocator.sharedInstance.joinRebellionViewController, animated: true)
    }
}
