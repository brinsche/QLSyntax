//
//  Preferences.swift
//  QLSyntaxApp
//
//  Created by Bastian Rinsche on 28.12.19.
//  Copyright © 2019 Bastian Rinsche. All rights reserved.
//

class QLPreferences {
    static let suite = "de.brinsche.QLSyntax.Defaults"
    static let fontFamily = "fontFamily"
    static let fontSize = "fontSize"
    static let themeName = "themeName"
    static let themeDirectory = "themeDirectory"
    static let syntaxDirectory = "syntaxDirectory"
    
    static let defaultFont = "Menlo" // SF Mono is not accessible for Webkit
    static let defaultFontSize = "12"
    static let defaultThemeName = "base16-eighties.dark" // TODO Replace with custom XCode Light/Dark Theme
    static let defaultThemeDirectory = "~/.config/qlsyntax/themes"
    static let defaultSyntaxDirectory = "~/.config/qlsyntax/syntaxes"
}
