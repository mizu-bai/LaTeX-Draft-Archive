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

    @objc func insertRoot() {
        text = text + "\\sqrt{}"
    }
}

extension String {
    func setSyntaxHighlight() -> NSMutableAttributedString {

        let attributedString = NSMutableAttributedString(string: self)

        attributedString.setAttributes(
                [
                    .font: UIFont(name: "Menlo-Regular", size: 16)!,
                    .foregroundColor: UIColor.darkText,
                ],
                range: NSRange(location: 0, length: count))

        // TODO: waiting for rearrangement, use external json file for editor style
        let rules: [[String: String]] = [
            [
                "pattern": "\\d+(\\.\\d+)?",
                "fontColorHex": "#E74C3C",
            ],
            [
                "pattern": "\\\\([a-zA-Z]+|\\||\\{|\\}|&|%|_|#|\\$|\\\\)",
                "fontColorHex": "#7D3C98",
            ],
            [
                "pattern": "(?<!\\\\)(\\{|\\})",
                "fontColorHex": "#117A65",
            ],
            [
                "pattern": "\\[|\\]",
                "fontColorHex": "#A04000",
            ],
            [
                "pattern": "\\(|\\)",
                "fontColorHex": "#F1C40F",
            ],
        ]

        do {
            for rule in rules {
                let regularExpression = try NSRegularExpression(pattern: rule["pattern"]!)
                let results = regularExpression.matches(in: self, range: NSRange(location: 0, length: count))
                for item in results {
                    attributedString.setAttributes(
                            [
                                .font: UIFont(name: "Menlo-Regular", size: 16)!,
                                .foregroundColor: UIColor(rule["fontColorHex"]!)
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
            UIBarButtonItem(
                    title: "\\",
                    style: .plain,
                    target: inputTextView,
                    action: #selector(UITextView.insertRoot)
            ),
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
        textView.attributedText = text.setSyntaxHighlight()
        textView.selectedRange = NSRange(location: loc,length: 0)
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
