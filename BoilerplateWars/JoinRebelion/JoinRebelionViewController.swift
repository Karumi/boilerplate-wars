//
//  ViewController.swift
//  BoilerplateWars
//
//  Created by Fran on 11/28/17.
//  Copyright © 2017 karumi. All rights reserved.
//

import UIKit

class JoinRebelionViewController: UIViewController {

    @IBOutlet weak var starFighterNameTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rebelionLogo: UIImageView!
    
    @IBOutlet var horizontalSpacingFighterAndJoin: NSLayoutConstraint!
    var presenter: JoinRebelionPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ServiceLocator.sharedInstance.getJoinRebelionPresenter(view: self)
        presenter.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func joinButtonTapped(_ sender: Any) {
        presenter.joinRequested()
    }

    @IBAction func editingFighterName(_ sender: UITextField) {
        presenter.figherNameChanged(sender.text)
    }
}

extension JoinRebelionViewController: JoinRebelionView {
    func setDescription(color: JoinRebelionPresenter.DescriptionColor) {
        switch color {
        case .Error:
            descriptionLabel.textColor = UIColor(red: 153/255, green: 0, blue: 51/255, alpha: 1)
        case .Success:
            descriptionLabel.textColor = UIColor(red: 255/255, green: 128/255, blue: 0, alpha: 1)
        }
    }

    func disableFighterName() {
        starFighterNameTextField.isEnabled = false
    }

    func clearFighterName() {
        starFighterNameTextField.text = ""
    }

    func setDescriptionHidden(_ isHidden: Bool) {
        descriptionLabel.isHidden = isHidden
    }

    func setJoinVisible(_ isVisible: Bool, animated: Bool) {
        if horizontalSpacingFighterAndJoin.isActive != isVisible {
            horizontalSpacingFighterAndJoin.isActive = isVisible
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    func setDescription(message: String) {
        descriptionLabel.text = message
    }
}

