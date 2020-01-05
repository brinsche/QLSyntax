//
//  Preferences.swift
//  QLSyntaxApp
//
//  Created by Bastian Rinsche on 28.12.19.
//  Copyright © 2019 Bastian Rinsche. All rights reserved.
//
import Combine
import Foundation

final class QLPreferences: ObservableObject {
    static let suite = "de.brinsche.QLSyntax.Defaults"
    static let fontFamily = "fontFamily"
    static let fontSize = "fontSize"
    static let themeName = "themeName"
    static let themeDirectory = "themeDirectory"
    static let syntaxDirectory = "syntaxDirectory"
    
    static let defaultFont = "Menlo" // SF Mono is not accessible for Webkit
    static let defaultFontSize = "12"
    static let defaultThemeName = "base16-eighties.dark" // TODO Replace with custom XCode Light/Dark Theme
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(QLPreferences.fontFamily, defaultValue: QLPreferences.defaultFont)
    var fontFamily: String { willSet { objectWillChange.send() }}
    
    @UserDefault(QLPreferences.fontSize, defaultValue: QLPreferences.defaultFontSize)
    var fontSize: String { willSet { objectWillChange.send() }}
    
    @UserDefault(QLPreferences.themeName, defaultValue: QLPreferences.defaultThemeName)
    var themeName: String { willSet { objectWillChange.send() }}
}

@propertyWrapper
struct UserDefault<T> {
    let defaults: UserDefaults
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.defaults = UserDefaults.init(suiteName: QLPreferences.suite)!
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return defaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
}
