//
//  AppDelegate.swift
//  pmenu
//
//  Created by Patrick on 11/19/19.
//  Copyright © 2019 Patrick. All rights reserved.
//

import Cocoa
import SwiftUI
import Foundation


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        let input = FileHandle.standardInput
//        let text = String(bytes: input.availableData, encoding: .utf8)
        
        let text = "Applications\nCode\nDesktop\nDocuments\nDownloads\nLibrary\nMovies\nMusic\nPictures\nPublic\npmenu\n"
                        
        let stdin = (text ?? "").components(separatedBy: .newlines).filter({(entry) in
            return !entry.isEmpty
        })
        
        let contentView = ContentView(stdin: stdin)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

