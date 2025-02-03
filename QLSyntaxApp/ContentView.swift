//
//  ContentView.swift
//  QLSyntaxApp
//
//  Created by Bastian Rinsche on 25.12.19.
//  Copyright © 2025 Bastian Rinsche. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var preferences = QLPreferences()

    var body: some View {
        VStack {
            TextField("fontFamily", text: $preferences.fontFamily)
            TextField("fontSize", text: $preferences.fontSize)
            TextField("themeName", text: $preferences.themeName)
            TextField("darkThemeName", text: $preferences.darkThemeName)
            Button(action: {
                let themeDirectory = FileManager.themeDirectory.path
                NSWorkspace.shared.openFile(themeDirectory, withApplication: "Finder")
            }, label: {
                Text("themeDirectory")
            })
            Button(action: {
                let syntaxDirectory = FileManager.syntaxDirectory.path
                NSWorkspace.shared.openFile(syntaxDirectory, withApplication: "Finder")
            }, label: {
                Text("syntaxDirectory")
            })
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
