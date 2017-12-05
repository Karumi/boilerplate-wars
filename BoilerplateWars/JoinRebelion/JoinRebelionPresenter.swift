//
//  JoinRebelionPresenter.swift
//  BoilerplateWars
//
//  Created by Fran on 11/29/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import Foundation

protocol JoinRebelionView {
    func setDescriptionHidden(_ isHidden: Bool)
    func setDescription(color: JoinRebelionPresenter.DescriptionColor)
    func setDescription(message: String)
    func setJoinVisible(_ visible: Bool, animated: Bool)
    func clearFighterName()
    func disableFighterName()
}

class JoinRebelionPresenter {

    enum DescriptionColor {
        case Error
        case Success
    }

    let view: JoinRebelionView

    var fighterName: String?
    var joinAttemps = 0
    let maxJoinAttemps = 3

    let errorMessages = [
        "Sorry, we can't use that fighter. Try with another one",
        "Ouch! Are you sure you wanna use that machine? The rebellion is trying to bring The Empire to its knees, don't make us lose our time.",
        "Attention: one more error and everything is gone. Choose your fighter wisely. It has to be fast; it has to be strong, it has to be e'X'cellent for the 'WING'.",
        "REJECTED! \n\nWe don't know if you feel The Force, but we are sure you don't have a proper fighter to help us."
    ]

    init(_ view: JoinRebelionView) {
        self.view = view
    }

    func viewDidLoad() {
        view.setDescriptionHidden(true)
        view.setJoinVisible(false, animated: false)
    }

    func figherNameChanged(_ newName: String?) {
        fighterName = newName

        guard let fighterName = fighterName else { return }
        view.setJoinVisible(fighterName.count >= 5, animated: true)
        view.setDescriptionHidden(true)
    }

    func joinRequested() {
        joinAttemps += 1

        if fighterName?.uppercased() == "XWing".uppercased() {
            view.setDescriptionHidden(false)
            view.setDescription(message: "Welcome on board Luke! We count on you to destroy The Empire.")
            view.setDescription(color: .Success)
            view.disableFighterName()
        } else {
            view.setDescriptionHidden(false)
            view.setDescription(message: errorMessages[joinAttemps - 1])
            view.clearFighterName()

            if joinAttemps - 1 == maxJoinAttemps{
                view.disableFighterName()
                view.setDescription(color: .Error)
            }
        }
        view.setJoinVisible(false, animated: true)
    }
}
