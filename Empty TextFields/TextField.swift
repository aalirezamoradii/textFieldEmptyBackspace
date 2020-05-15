//
//  TextField.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 1/28/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import UIKit
@IBDesignable
class TextField: UITextField {
    
    weak var delegatePlus:UITextFieldDelegatePlus? {
        didSet {
            delegate = delegatePlus
        }
    }
    
    private lazy var padding = UIEdgeInsets.zero
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(textFeildChangeEditing(_:)), for: .editingChanged)
    }
    @objc func textFeildChangeEditing(_ textField: UITextField) {
        delegatePlus?.textFeildChangeEditing(self)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    @IBInspectable public var bottomInset: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    @IBInspectable public var leftInset: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    @IBInspectable public var rightInset: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    @IBInspectable public var topInset: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor:UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
