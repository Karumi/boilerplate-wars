//
//  ServiceLocator.swift
//  BoilerplateWars
//
//  Created by Fran on 11/29/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import Foundation

class ServiceLocator {
    // To reduce the code required to do dependency injection, we are gonna
    // set a very basic service locator where the ViewControllers will be able
    // to satisfy their dependencies.

    static var sharedInstance = ServiceLocator()

    func getJoinRebelionPresenter() -> JoinRebelionPresenter {
        return JoinRebelionPresenter()
    }
}
