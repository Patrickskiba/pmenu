//
//  FilteringTextView.swift
//  pmenu
//
//  Created by Patrick on 11/19/19.
//  Copyright © 2019 Patrick. All rights reserved.
//

import SwiftUI
import AppKit

struct FilteringTextView: NSViewControllerRepresentable {
    private let vc = FilteringTextViewController()
    var placeholderString: String
    var changeHandler: ((String)->Void)?
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<FilteringTextView>) -> NSViewController {
        vc.placeholderString = placeholderString
        vc.textFieldChangedHandler = changeHandler
        return vc
    }
    
    func updateNSViewController(_ nsViewController: NSViewController, context: NSViewControllerRepresentableContext<FilteringTextView>) {
        
    }

}

