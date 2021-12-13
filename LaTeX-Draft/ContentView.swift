//
//  ContentView.swift
//  LaTeX-Draft
//
//  Created by mizu bai on 2021/12/12.
//
//

import SwiftUI

struct ContentView: View {
    @State private var latex: String = "W = - \\int_{V_1}^{V_2} p \\mathrm{d} V"
    @ObservedObject var mathUILabelModel: MathUILabelModel = MathUILabelModel()
    @Environment(\.colorScheme) var colorScheme

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack {
            MathUILabel($latex)
                    .labelMode(mathUILabelModel.labelMode)
                    .textAlignment(mathUILabelModel.textAlignment)
                    .fontSize(mathUILabelModel.fontSize)
                    .font(mathUILabelModel.font)
                    .textColor(mathUILabelModel.textColor)
                    .padding()
            HStack {
                Text("Display style: ")
                        .padding()
                Spacer()
                Button(mathUILabelModel.labelMode == .display ? "Display" : "Inline") {
                    if mathUILabelModel.labelMode == .display {
                        mathUILabelModel.labelMode = .text
                    } else {
                        mathUILabelModel.labelMode = .display
                    }
                }.padding()
            }.padding()
            TextEditor(text: $latex)
                    .background(Color(colorScheme == .light ? .lightGray : .darkGray))
                    .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
