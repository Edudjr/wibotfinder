//
//  SecondScreenViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 09/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

protocol SecondScreenViewControllerDelegate: class {
    func didEnter(text: String)
}

class SecondScreenViewController: UIViewController {
    @IBOutlet weak var queryTextField: UITextField!
    
    var delegate: SecondScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        queryTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setValidTextField() {
        queryTextField.backgroundColor = UIColor.white.withAlphaComponent(1)
    }
    
    func setInvalidTextField() {
        queryTextField.backgroundColor = UIColor.red.withAlphaComponent(0.05)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func didClickButton(_ sender: Any) {
        if let text = queryTextField.text, !text.isEmpty {
            delegate?.didEnter(text: text)
            setValidTextField()
        } else {
            setInvalidTextField()
        }
    }
}

extension SecondScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setValidTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}
