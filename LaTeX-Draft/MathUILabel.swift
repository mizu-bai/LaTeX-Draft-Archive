//
// Created by mizu bai on 2021/12/12.
//

import SwiftUI
import iosMath

struct MathUILabel: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme

    @Binding var latex: String
    private var labelMode: MTMathUILabelMode   = .display
    private var textAlignment: MTTextAlignment = .left
    private var fontSize: CGFloat              = MTFontManager().defaultFont().fontSize
    private var font: MTFont                   = MTFontManager().defaultFont()
    private var textColor: UIColor             = .black

    private var _labelModel: MathUILabelModel = MathUILabelModel()
    var labelModel: MathUILabelModel {
        set {
            _labelModel   = newValue
            labelMode     = _labelModel.labelMode
            textAlignment = _labelModel.textAlignment
            fontSize      = _labelModel.fontSize
            font          = _labelModel.font
            textColor     = _labelModel.textColor
        }
        get {
            _labelModel
        }
    }

    init(_ latex: Binding<String>,
         labelModel: MathUILabelModel = MathUILabelModel()
         ) {
        self._latex = latex
        self.labelModel = labelModel
    }

    func makeUIView(context: Context) -> MTMathUILabel {
        let label = MTMathUILabel()
        label.latex         = latex
        label.labelMode     = labelMode
        label.textAlignment = textAlignment
        label.fontSize      = fontSize
        label.font          = font
        label.textColor     = textColor
        return label
    }

    func updateUIView(_ uiView: MTMathUILabel, context: Context) {
        DispatchQueue.main.async {
            uiView.latex         = latex
            uiView.labelMode     = labelMode
            uiView.textAlignment = textAlignment
            uiView.fontSize      = fontSize
            uiView.font          = font
            uiView.textColor     = textColor
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

    func labelModel(_ labelModel: MathUILabelModel) -> Self {
        then {
            $0.labelModel = labelModel
        }
    }
}
