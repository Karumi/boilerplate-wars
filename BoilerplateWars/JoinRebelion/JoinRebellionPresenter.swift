//
//  JoinRebelionPresenter.swift
//  BoilerplateWars
//
//  Created by Fran on 11/29/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import Foundation

class JoinRebellionPresenter {

    class VisibleWithAnimation: NSObject {
        let visible: Bool
        let animation: Bool
        init(_ visible: Bool, animation: Bool) {
            self.visible = visible
            self.animation = animation
        }
    }

    class DescriptionColor: NSObject {
        enum Color {
            case Default
            case Error
            case Success
        }
        let color: Color
        private init(_ color: Color) {
            self.color = color
        }

        static let Default = DescriptionColor(Color.Default)
        static let Error = DescriptionColor(Color.Error)
        static let Success = DescriptionColor(Color.Success)
    }

    class JoinRebellionViewModel: NSObject {
        fileprivate var fighterName: String? {
            didSet {
                if let fighterName = fighterName {
                    isJoinButtonVisible = VisibleWithAnimation(fighterName.count >= 5, animation: true)
                    isDescriptionHidden = true
                }
            }
        }
        private var joinAttemps = 0
        private let maxJoinAttemps = 3
        let errorMessages = [
            "Sorry, we can't use that fighter. Try with another one",
            "Ouch! Are you sure you wanna use that machine? The rebellion is trying to bring The Empire to its knees, don't make us lose our time.",
            "Attention: one more error and everything is gone. Choose your fighter wisely. It has to be fast; it has to be strong, it has to be e'X'cellent for the 'WING'.",
            "REJECTED! \n\nWe don't know if you feel The Force, but we are sure you don't have a proper fighter to help us."
        ]

        fileprivate enum State {
            case Started
            case Joined
            case Rejected
            case Failed
        }

        fileprivate var state: State = .Started {
            didSet {
                switch state {
                case .Started:
                    isDescriptionHidden = true
                    isJoinButtonVisible = VisibleWithAnimation(false, animation: false)
                    isFighterNameEnabled = true
                case .Joined:
                    isDescriptionHidden = false
                    isFighterNameEnabled = false
                    descriptionColor = .Success
                    descriptionText = "Welcome on board Luke! We count on you to destroy The Empire."
                    isJoinButtonVisible = VisibleWithAnimation(false, animation: true)
                case .Rejected:
                    isDescriptionHidden = false
                    descriptionText = errorMessages[joinAttemps - 1]
                    isFighterNameEnabled = false
                    fighterNameText = ""
                    descriptionColor = .Error
                    isJoinButtonVisible = VisibleWithAnimation(false, animation: true)
                case .Failed:
                    isDescriptionHidden = false
                    descriptionText = errorMessages[joinAttemps - 1]
                    fighterNameText = ""
                    descriptionColor = .Default
                    isJoinButtonVisible = VisibleWithAnimation(false, animation: true)
                }
            }
        }

        @objc dynamic var isDescriptionHidden: Bool = false
        @objc dynamic var descriptionText: String = ""
        @objc dynamic var isJoinButtonVisible: VisibleWithAnimation = VisibleWithAnimation(false, animation: false)
        @objc dynamic var isFighterNameEnabled: Bool = false
        @objc dynamic var fighterNameText: String = ""
        @objc dynamic var descriptionColor: DescriptionColor = DescriptionColor.Default

        fileprivate func joinAttempt() {
            joinAttemps += 1
            if fighterName?.uppercased() == "x-wing".uppercased() {
                state = .Joined
            } else {
                state = (joinAttemps - 1 == maxJoinAttemps) ? .Rejected : .Failed
            }
        }
    }

    var fighterName: String?
    var joinAttemps = 0
    let maxJoinAttemps = 3

    var viewModel: JoinRebellionViewModel

    init() {
        viewModel = JoinRebellionViewModel()
    }

    func viewDidLoad() {
        viewModel.state = .Started
    }

    func figherNameChanged(_ newName: String?) {
        viewModel.fighterName = newName
    }

    func joinRequested() {
        viewModel.joinAttempt()
    }
}
