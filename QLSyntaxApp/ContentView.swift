//
//  ContentView.swift
//  QLSyntaxApp
//
//  Created by Bastian Rinsche on 25.12.19.
//  Copyright © 2019 Bastian Rinsche. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var preferences = QLPreferences()

    var body: some View {
        VStack {
            TextField("fontFamily", text: $preferences.fontFamily)
            TextField("fontSize", text: $preferences.fontSize)
            TextField("themeName", text: $preferences.themeName)
            TextField("themeDirectory", text: $preferences.themeDirectory)
            TextField("syntaxDirectory", text: $preferences.syntaxDirectory)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
