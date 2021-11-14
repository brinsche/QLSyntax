//
//  PreviewViewController.swift
//  QLSyntaxPlugin
//
//  Created by Bastian Rinsche on 25.12.19.
//  Copyright © 2019 Bastian Rinsche. All rights reserved.
//

import Cocoa
import Quartz
import WebKit

class PreviewViewController: NSViewController, QLPreviewingController {
    let previewCompletionNotifier = PreviewCompletionNotifier()

    @IBOutlet var webView: WKWebView!

    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.
        webView.navigationDelegate = previewCompletionNotifier
    }

    /*
     * Implement this method and set QLSupportsSearchableItems to YES in the Info.plist of the extension if you support CoreSpotlight.
     *
    func preparePreviewOfSearchableItem(identifier: String, queryString: String?, completionHandler handler: @escaping (Error?) -> Void) {
        // Perform any setup necessary in order to prepare the view.
        
        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        handler(nil)
    }
     */
    
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        
        // Add the supported content types to the QLSupportedContentTypes array in the Info.plist of the extension.
        
        // Perform any setup necessary in order to prepare the view.
        
        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        previewCompletionNotifier.setHandler(handler)

        let defaults = UserDefaults.init(suiteName: QLPreferences.suite)!
        let font = (defaults.string(forKey: QLPreferences.fontFamily) ?? QLPreferences.defaultFont).cString(using: .utf8)
        let fontSize = (defaults.string(forKey: QLPreferences.fontSize) ?? QLPreferences.defaultFontSize).cString(using: .utf8)
        let normalthemeName = (defaults.string(forKey: QLPreferences.themeName) ?? QLPreferences.defaultThemeName).cString(using: .utf8)
        let darkThemeName = (defaults.string(forKey: QLPreferences.darkThemeName) ?? QLPreferences.defaultThemeName).cString(using: .utf8)
        let themeName = isDarkMode(view: self.view) ? darkThemeName : normalthemeName
        let themeDirectory = FileManager.themeDirectory.path.cString(using: .utf8)
        let syntaxDirectory = FileManager.syntaxDirectory.path.cString(using: .utf8)
        
        let path = url.path.cString(using: .utf8)
        let result = String(cString: syntax_highlight(path, font, fontSize, themeName, themeDirectory, syntaxDirectory))
        webView.loadHTMLString(result, baseURL: nil)
    }
    
    func isDarkMode(view: NSView) -> Bool {
        if #available(OSX 10.14, *) {
            return view.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        }
        return false
    }
}

class PreviewCompletionNotifier: NSObject, WKNavigationDelegate {
    var completionHandler: ((Error?) -> Void)?
    
    func setHandler(_ handler: @escaping (Error?) -> Void) {
        self.completionHandler = handler
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        completionHandler?(nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        completionHandler?(nil)
    }
}
