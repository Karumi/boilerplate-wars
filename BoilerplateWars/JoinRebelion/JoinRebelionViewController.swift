//
//  ViewController.swift
//  BoilerplateWars
//
//  Created by Fran on 11/28/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import UIKit

class JoinRebelionViewController: UIViewController {

    @IBOutlet weak var starFighterNameTextField: UITextField! {
        didSet {
            observer.from(presenter.viewModel, \.fighterNameText).mapAsOptional().to(starFighterNameTextField, \.text)
            observer.from(presenter.viewModel, \.isFighterNameEnabled).to(starFighterNameTextField, \.isEnabled)
        }
    }
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            observer.from(presenter.viewModel, \.isDescriptionHidden).to(descriptionLabel, \.isHidden)
            observer.from(presenter.viewModel, \.descriptionText).mapAsOptional().to(descriptionLabel, \.text)
            observer.from(presenter.viewModel, \.descriptionColor).map({
                switch $0.color {
                case .Default: return UIColor.black
                case .Error: return UIColor(red: 153/255, green: 0, blue: 51/255, alpha: 1)
                case .Success: return UIColor(red: 255/255, green: 128/255, blue: 0, alpha: 1)
                }
            }).to(descriptionLabel, \.textColor)
        }
    }
    @IBOutlet weak var rebelionLogo: UIImageView!
    
    @IBOutlet var horizontalSpacingFighterAndJoin: NSLayoutConstraint!

    var presenter: JoinRebelionPresenter!

    var observer = Observer()

    override func awakeFromNib() {
        presenter = ServiceLocator.sharedInstance.getJoinRebelionPresenter()
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        // Everything related to animations cannot be in didSet
        observer.from(presenter.viewModel, \.isJoinButtonVisible).to { visibleWithAnimation in
            self.horizontalSpacingFighterAndJoin.isActive = visibleWithAnimation.visible
            if visibleWithAnimation.animation {
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    @IBAction func joinButtonTapped(_ sender: Any) {
        presenter.joinRequested()
    }

    @IBAction func editingFighterName(_ sender: UITextField) {
        presenter.figherNameChanged(sender.text)
    }
}
