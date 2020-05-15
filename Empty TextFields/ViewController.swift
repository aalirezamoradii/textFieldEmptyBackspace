//
//  ViewController.swift
//  Empty TextFields
//
//  Created by Alireza Moradi on 2/5/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textFeild: [TextField]! {
        didSet {
            for txt in textFeild {
                txt.delegatePlus = self
            }
        }
    }
    
    private let btnBack = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    private func start() {
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        btnBack.backgroundColor = .clear
        btnBack.layer.cornerRadius = 5
        btnBack.addTarget(self, action: #selector(textFeildBack), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(addviewtokeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    @objc private func addviewtokeyboard(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let safeArea = view.safeAreaInsets.bottom
            let x = keyboardRectangle.height / 4
            let width = (keyboardRectangle.width / 3) - 8
            let bottom = safeArea == 0 ? 2 : x+4
            let height = x - (bottom/4) - 8
            let windowCount = UIApplication.shared.windows.count
            let keyboard = UIApplication.shared.windows[windowCount-1]
            keyboard.addSubview(btnBack)

            keyboard.trailingAnchor.constraint(equalTo: btnBack.trailingAnchor, constant: 6).isActive = true
            btnBack.widthAnchor.constraint(equalToConstant: width).isActive = true
            btnBack.heightAnchor.constraint(equalToConstant: height).isActive = true
            keyboard.bottomAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: bottom).isActive = true
            
        }
    }
    @objc private func textFeildBack() {
        for i in 0..<textFeild.count {
            if textFeild[i].isFirstResponder {
                if !textFieldEmpty(i-1) {
                    textFeild[i-1].text?.removeLast()
                }
                textFeild[i-1].becomeFirstResponder()
            }
        }
    }
    
}
extension ViewController: UITextFieldDelegatePlus {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldEmpty(_ index: Int) -> Bool {
        textFeild[index].text?.isEmpty ?? true
    }
    func textFeildChangeEditing(_ textField: UITextField) {
        switch textField {
        case textFeild[0]:
            if !textFieldEmpty(0) { textFeild[1].becomeFirstResponder() }
        case textFeild[1]:
            if !textFieldEmpty(1) {
                btnBack.isHidden = true
                textFeild[2].becomeFirstResponder()
            } else {
                btnBack.isHidden = false
            }
        case textFeild[2]:
            if !textFieldEmpty(2) {
                btnBack.isHidden = true
                textFeild[3].becomeFirstResponder()
            } else {
                btnBack.isHidden = false
            }
        case textFeild[3]:
            if !textFieldEmpty(3) {
                btnBack.isHidden = true
                textFeild[3].resignFirstResponder()
            } else {
                btnBack.isHidden = false
            }
        default:
            break
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        guard let currentString: NSString = textField.text as NSString? else { return true }
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case textFeild[0]:
            btnBack.isHidden = true
        case textFeild[1]:
            if !textFieldEmpty(1) {
                btnBack.isHidden = true
            } else {
                btnBack.isHidden = false
            }
        case textFeild[2]:
            if !textFieldEmpty(2) {
                btnBack.isHidden = true
            } else {
                btnBack.isHidden = false
            }
        case textFeild[3]:
            if !textFieldEmpty(3) {
                btnBack.isHidden = true
            } else {
                btnBack.isHidden = false
            }
        default:
            break
        }
    }
}
protocol UITextFieldDelegatePlus: UITextFieldDelegate {
    func textFeildChangeEditing(_ textField: UITextField)
}
