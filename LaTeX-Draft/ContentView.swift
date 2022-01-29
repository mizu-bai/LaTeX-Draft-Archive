//
//  ContentView.swift
//  LaTeX-Draft
//
//  Created by mizu bai on 2021/12/12.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EditorView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Editor")
                }

            ReferenceView()
                .tabItem {
                    Image(systemName: "tablecells")
                    Text("Reference")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
