//
// Created by mizu bai on 2021/12/12.
//

import SwiftUI
import iosMath

struct MathUILabel: UIViewRepresentable {
    @Binding var latex: String
    private var labelMode: MTMathUILabelMode
    private var textAlignment: MTTextAlignment
    private var fontSize: CGFloat
    private var font: MTFont
    private var textColor: UIColor

    init(_ latex: Binding<String>,
         labelMode: MTMathUILabelMode = .display,
         textAlignment: MTTextAlignment = .left,
         fontSize: CGFloat = MTFontManager().defaultFont().fontSize,
         font: MTFont = MTFontManager().defaultFont(),
         textColor: UIColor = .black
         ) {
        self._latex = latex
        self.labelMode = labelMode
        self.textAlignment = textAlignment
        self.fontSize = fontSize
        self.font = font
        self.textColor = textColor
    }

    func makeUIView(context: Context) -> MTMathUILabel {
        let label = MTMathUILabel()
        label.latex = latex
        label.labelMode = labelMode
        label.textAlignment = textAlignment
        label.fontSize = fontSize
        label.font = font
        label.textColor = textColor
        return label
    }

    func updateUIView(_ uiView: MTMathUILabel, context: Context) {
        DispatchQueue.main.async {
            uiView.latex = latex
            uiView.labelMode = labelMode
            uiView.textAlignment = textAlignment
            uiView.fontSize = fontSize
            uiView.font = font
            uiView.textColor = textColor
        }
    }

    func makeCoordinator() -> Coordinator {
        .init(latex: $latex)
    }

    class Coordinator: NSObject {
        @Binding var latex: String
        init(latex: Binding<String>) {
            self._latex = latex
        }
    }

    func then(_ body: (inout Self) -> Void) -> Self {
        var result = self
        body(&result)
        return result
    }

    func labelMode(_ labelMode: MTMathUILabelMode) -> Self {
        then {
            $0.labelMode = labelMode
        }
    }

    func textAlignment(_ textAlignment: MTTextAlignment) -> Self {
        then {
            $0.textAlignment = textAlignment
        }
    }

    func fontSize(_ fontSize: CGFloat) -> Self {
        then {
            $0.fontSize = fontSize
        }
    }

    func font(_ font: MTFont) -> Self {
        then {
            $0.font = font
        }
    }

    func textColor(_ textColor: UIColor) -> Self {
        then {
            $0.textColor = textColor
        }
    }
}
