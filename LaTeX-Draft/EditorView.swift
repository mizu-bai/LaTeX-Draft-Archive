//
// Created by mizu bai on 2022/1/27.
//

import SwiftUI

struct EditorView: View {

    @State private var latex: String = ""
    @ObservedObject var mathUILabelModel: MathUILabelModel = MathUILabelModel()
    @Environment(\.colorScheme) var colorScheme
    var isLight: Bool {
        colorScheme == .light
    }

    init() {
        UITextView.appearance().backgroundColor = .clear
        mathUILabelModel.textColor = UIColor { (trainCollection) -> UIColor in
            trainCollection.userInterfaceStyle == .light ? .black : .white
        }
    }

    var body: some View {
        VStack {
            MathUILabel($latex)
                    .labelModel(mathUILabelModel)
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
                }
                        .padding()
            }
                    .padding()
            InputTextView($latex)
                    .padding()
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
