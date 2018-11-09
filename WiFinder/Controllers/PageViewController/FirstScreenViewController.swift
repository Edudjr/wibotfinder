//
//  FirstScreenViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 09/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

protocol FirstScreenViewControllerDelegate: class {
    func didClick(action: FirstScreenViewController.Action)
}

class FirstScreenViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    struct Action {
        let uibutton: UIButton
        let description: String
        let type: MediaType
    }
    
    let actions = [
        Action(uibutton: UIButton(), description: "Movies", type: .movie),
        Action(uibutton: UIButton(), description: "TV Shows", type: .tvShow),
        Action(uibutton: UIButton(), description: "Music", type: .music),
        Action(uibutton: UIButton(), description: "Everything", type: .all)
    ]
    
    weak var delegate: FirstScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        if let firstView = stackView.arrangedSubviews.first {
            stackView.removeArrangedSubview(firstView)
        }
        for action in actions {
            action.uibutton.setTitle(action.description, for: .normal)
            action.uibutton.setTitleColor(self.view.tintColor, for: .normal)
            action.uibutton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(action.uibutton)
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        if let index = actions.index(where: { $0.uibutton == sender }) {
            delegate?.didClick(action: actions[index])
        }
    }
}
