//
//  AppDelegate.swift
//  QLSyntaxApp
//
//  Created by Bastian Rinsche on 25.12.19.
//  Copyright © 2025 Bastian Rinsche. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        let themeDirectory = FileManager.themeDirectory
        try! FileManager.default.createDirectory(at: themeDirectory, withIntermediateDirectories: true, attributes: nil)

        let syntaxDirectory = FileManager.syntaxDirectory
        try! FileManager.default.createDirectory(at: syntaxDirectory, withIntermediateDirectories: true, attributes: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

