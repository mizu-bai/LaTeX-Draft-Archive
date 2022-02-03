//
//  InputTextView.swift
//  LaTeX-Draft
//
//  Created by mizu bai on 2022/1/28.
//

import SwiftUI
import UIKit
import Combine
import UIColor_Hex_Swift

extension UITextView {
    // MARK: - Add Tool Bar
    func toolBar(_ barItems: [UIBarButtonItem]) {
        let toolBar = UIToolbar(frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: UIScreen.main.bounds.size.width,
                height: 44.0))
        toolBar.setItems(barItems, animated: false)
        inputAccessoryView = toolBar
    }

    @objc func doneButtonDidClick(button: UIBarButtonItem) {
        resignFirstResponder()
    }
}

extension String {
    func setSyntaxHighlight(with editorTheme: EditorThemeModel) -> NSMutableAttributedString {

        let attributedString = NSMutableAttributedString(string: self)

        attributedString.setAttributes(
                [
                    .font: UIFont(name: editorTheme.fontName, size: editorTheme.fontSize)!,
                    .foregroundColor: UIColor(editorTheme.fontColorHex),
                ],
                range: NSRange(location: 0, length: count))

        do {
            for rule in editorTheme.highlightRules {
                let regularExpression = try NSRegularExpression(pattern: rule.pattern)
                let results = regularExpression.matches(in: self, range: NSRange(location: 0, length: count))
                for item in results {
                    attributedString.setAttributes(
                            [
                                .font: UIFont(name: editorTheme.fontName, size: editorTheme.fontSize)!,
                                .foregroundColor: UIColor(rule.fontColorHex)
                            ],
                            range: item.range)
                }
            }
        } catch {
            print(error)
        }

        return attributedString
    }
}

struct InputTextView: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<InputTextView>

    @Binding var text: String

    let editorTheme = {() -> EditorThemeModel in
        let url = Bundle.main.url(forResource: "editor_theme_default", withExtension: "json")
        let modelData = try! Data(contentsOf: url!)
        let decoder = {() -> JSONDecoder in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        let model = try! decoder.decode(EditorThemeModel.self, from: modelData)
        return model
    }()

    init(_ text: Binding<String>) {
        self._text = text
    }

    // MARK: - Life Circle Methods
    func makeUIView(context: Context) -> UITextView {
        let inputTextView = UITextView()
        inputTextView.delegate = context.coordinator
        inputTextView.font = UIFont(name: "Menlo-Regular", size: 16)
        inputTextView.autocapitalizationType = .none
        inputTextView.autocorrectionType = .no

        inputTextView.toolBar([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(
                    image: UIImage(systemName: "keyboard.chevron.compact.down"),
                    style: .plain,
                    target: inputTextView,
                    action: #selector(UITextView.doneButtonDidClick(button:))),
        ])
        return inputTextView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        let loc = textView.selectedRange.location
        print(loc)
        textView.attributedText = text.setSyntaxHighlight(with: editorTheme)
        textView.selectedRange = NSRange(location: loc,length: 0)
        print(loc)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, UITextViewDelegate {

        var parent: InputTextView

        init(_ parent: InputTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textViewDidBeginEditing(_ textView: UITextView) {

        }

        func textViewDidEndEditing(_ textView: UITextView) {

        }
    }
}
