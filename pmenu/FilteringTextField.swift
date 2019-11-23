//
//  FilteringTextField.swift
//  pmenu
//
//  Created by Patrick on 11/19/19.
//  Copyright © 2019 Patrick. All rights reserved.
//
import SwiftUI
import AppKit

class FilteringTextViewController: NSViewController {
    let textfield = FilteringTextField()

    var textFieldChangedHandler: ((String)->Void)?
    var placeholderString: String = ""


    
    override func loadView() {
        textfield.textFieldChangedHandler = textFieldChangedHandler
        textfield.placeholderString = placeholderString
        self.view = textfield
    }
    
    override func viewDidAppear() {
        textfield.becomeFirstResponder()
    }
}

class FilteringTextField: NSTextField, NSTextFieldDelegate {
    var textFieldChangedHandler: ((String)->Void)?
    
    override func textDidChange(_ notification: Notification) {
        if let textObject = (notification.object as? NSTextView) {
            if let didChange = textFieldChangedHandler {
                didChange(textObject.string)
            }
        }
    }
}

