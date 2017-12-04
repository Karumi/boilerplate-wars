//
//  JoinRebelionScreenshotTests.swift
//  BoilerplateWarsTests
//
//  Created by Fran on 12/4/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import KIF

@testable import BoilerplateWars

class JoinRebellionScreenshotTests: BaseUITestCase {
    private var serviceLocator: ServiceLocator!
    private var driver: Driver!

    override func setUp() {
        super.setUp()

        ServiceLocator.nuke()
        serviceLocator = ServiceLocator.sharedInstance

        driver = Driver(self)
    }

    func test_show_empty_join_rebellion_form() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_join_button_is_not_shown_when_name_field_has_less_than_five_characters() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.typeName("abcd")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_join_button_is_shown_when_name_field_has_at_least_five_characters() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.typeName("abcde")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_shows_first_error_message() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.enterTextAsName("abcde")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_shows_second_error_message() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.enterTextAsName("abcde")
        driver.enterTextAsName("fghij")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_shows_third_error_message() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.enterTextAsName("abcde")
        driver.enterTextAsName("fghij")
        driver.enterTextAsName("klmno")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_shows_rejected_error_when_enters_fourth_wrong_name() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.enterTextAsName("abcde")
        driver.enterTextAsName("fghij")
        driver.enterTextAsName("klmno")
        driver.enterTextAsName("pqrst")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }

    func test_shows_successful_message_for_xwing_name() {
        serviceLocator.rootNavigator.goToJoinRebellion()

        driver.enterTextAsName("xwing")

        let view = serviceLocator.currentWindow?.rootViewController?.view!
        verify(view!)
    }
}

fileprivate class Driver {
    let testCase: XCTestCase!

    init(_ testCase: XCTestCase) {
        self.testCase = testCase
    }

    func typeName(_ text: String) {
        testCase.tester().enterText(text, intoViewWithAccessibilityLabel: JoinRebellionViewController.AccessibilityLabel.starFighterNameTextField)
    }

    func tapJoin() {
        testCase.tester().tapView(withAccessibilityLabel: JoinRebellionViewController.AccessibilityLabel.joinRebellionButton)
    }

    func enterTextAsName(_ text: String) {
        typeName(text)
        tapJoin()
    }
}
