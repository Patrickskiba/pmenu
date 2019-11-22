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
    override func viewDidAppear() {
        
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

