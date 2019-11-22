//
//  FilteringTextView.swift
//  pmenu
//
//  Created by Patrick on 11/19/19.
//  Copyright © 2019 Patrick. All rights reserved.
//

import SwiftUI
import AppKit

struct FilteringTextView: NSViewRepresentable {
    private let tmpView = FilteringTextField()
    var placeholderString: String
    var changeHandler: ((String)->Void)?
    
    func makeNSView(context: NSViewRepresentableContext<FilteringTextView>) -> FilteringTextField {
        tmpView.delegate = tmpView
        tmpView.placeholderString = placeholderString
        tmpView.textFieldChangedHandler = changeHandler
        return tmpView
    }
    
    func updateNSView(_ uiView: FilteringTextField, context: NSViewRepresentableContext<FilteringTextView>) {
//            if uiView.acceptsFirstResponder {
//                uiView.becomeFirstResponder()
//            }
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

