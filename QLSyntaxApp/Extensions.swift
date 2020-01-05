//
//  Extensions.swift
//  QLSyntax
//
//  Created by Bastian Rinsche on 05.01.20.
//  Copyright © 2020 Bastian Rinsche. All rights reserved.
//

import Foundation

extension FileManager {
    static var qlSyntaxFiles: URL {
        get {
            FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "de.brinsche.QLSyntax.Files")!
        }
    }
    
    static var syntaxDirectory: URL {
        get {
             qlSyntaxFiles.appendingPathComponent("Syntaxes")
        }
    }
    
    static var themeDirectory: URL {
        get {
            qlSyntaxFiles.appendingPathComponent("Themes")
        }
    }
}
