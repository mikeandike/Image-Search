//
//  UIViewExtension.swift
//  Image Search
//
//  Created by Michael Sacks on 1/10/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

extension UIView {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(UIView.hideKeyboard))
        drag.cancelsTouchesInView = false
        self.addGestureRecognizer(drag)
    }
    
    @objc private func hideKeyboard() {
        self.endEditing(true)
    }
}
