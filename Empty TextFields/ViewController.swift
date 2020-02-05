//
//  ViewController.swift
//  Empty TextFields
//
//  Created by Alireza Moradi on 2/5/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textFeild: [UITextField]!
    
    private let btnBack = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    private func start() {
        btnBack.backgroundColor = .clear
        btnBack.layer.cornerRadius = 5
        btnBack.addTarget(self, action: #selector(textFeildBack), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(addviewtokeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    @objc private func addviewtokeyboard(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let safeArea = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
                .filter({$0.isKeyWindow}).first?.safeAreaInsets.bottom
            let x = keyboardRectangle.height / 4
            let h = ((keyboardRectangle.height - x) / 4) - 8
            let w = (keyboardRectangle.width / 3) - 8
            let z = safeArea == 0 ? 3 : x+4
            let width = UIScreen.main.bounds.width
            btnBack.frame.size = CGSize(width: w, height: h)
            btnBack.frame.origin = CGPoint(x: width - w - 8, y: (keyboardRectangle.maxY - h) - z)
            let windowCount = UIApplication.shared.windows.count
            UIApplication.shared.windows[windowCount-1].addSubview(btnBack)
        }
    }
    @objc private func textFeildBack() {
        for i in 0..<textFeild.count {
            if textFeild[i].isFirstResponder {
                textFeild[i-1].text?.removeLast()
                textFeild[i-1].becomeFirstResponder()
            }
        }
    }

}
extension ViewController: UITextFieldDelegatePlus {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFeildChangeEditing(_ textField: UITextField) {
        switch textField {
        case textFeild[0]:
            if !(textFeild[0].text?.isEmpty ?? true) { textFeild[1].becomeFirstResponder() }
        case textFeild[1]:
            if !(textFeild[1].text?.isEmpty ?? true) {
                btnBack.isHidden = true
                textFeild[2].becomeFirstResponder()
            } else {
                btnBack.isHidden = false
            }
        case textFeild[2]:
            if !(textFeild[2].text?.isEmpty ?? true) {
                btnBack.isHidden = true
                textFeild[3].becomeFirstResponder()
            } else {
                btnBack.isHidden = false
            }
        case textFeild[3]:
            if !(textFeild[3].text?.isEmpty ?? true) {
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
            if !(textFeild[1].text?.isEmpty ?? true) {
                btnBack.isHidden = true
            } else {
                btnBack.isHidden = false
            }
        case textFeild[2]:
            if !(textFeild[2].text?.isEmpty ?? true) {
                btnBack.isHidden = true
            } else {
                btnBack.isHidden = false
            }
        case textFeild[3]:
            if !(textFeild[3].text?.isEmpty ?? true) {
                btnBack.isHidden = true
            } else {
                btnBack.isHidden = false
            }
        default:
            break
        }
    }
}
@objc public protocol UITextFieldDelegatePlus: UITextFieldDelegate {
    func textFeildChangeEditing(_ textField: UITextField)
}
