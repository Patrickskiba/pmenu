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
    var textFieldEditingEndedHandler: (() -> Void)?
    var vcEvent: ((String) -> Void)?

    var placeholderString: String = ""
    
    func keyPressed(with event: NSEvent) -> Bool {
        print(event.modifierFlags)

        if (event.modifierFlags.rawValue == 256 ) {
            return true
        }
        
        if (event.modifierFlags.rawValue == 131330 ) {
            return true
        }
        
        if (event.modifierFlags.rawValue) == 262401 {
            if let callEvent = vcEvent {
                if (event.charactersIgnoringModifiers == "p") {
                    callEvent("prev")
                }
                if (event.charactersIgnoringModifiers == "n") {
                    callEvent("next")
                }
            }
            return false
        }
        
        if (event.modifierFlags.rawValue == 1048840) {
            if (event.charactersIgnoringModifiers == "q") {
                return true
            }
        }
        
        return false
    }
    
    override func loadView() {
        textfield.textFieldChangedHandler = textFieldChangedHandler
        textfield.textFieldEditingEndedHandler = textFieldEditingEndedHandler
        textfield.placeholderString = placeholderString
        self.view = textfield
    }
    
    override func viewDidLoad() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            let validKey = self.keyPressed(with: $0)
            if validKey == true {
                return $0
            } else {
                return nil
            }
        }
    }
    
    override func viewDidAppear() {
        textfield.becomeFirstResponder()
    }
}

class FilteringTextField: NSTextField, NSTextFieldDelegate {
    var textFieldChangedHandler: ((String)->Void)?
    var textFieldEditingEndedHandler: (() -> Void)?
    
    override func textDidEndEditing(_ notification: Notification) {
        if let endedEditing = textFieldEditingEndedHandler {
            endedEditing()
        }
    }
    
    override func textDidChange(_ notification: Notification) {
        if let textObject = (notification.object as? NSTextView) {
            if let didChange = textFieldChangedHandler {
                didChange(textObject.string)
            }
        }
    }
}

