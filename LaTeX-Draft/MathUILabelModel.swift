//
// Created by mizu bai on 2021/12/13.
//

import SwiftUI
import Combine

class MathUILabelModel: ObservableObject {
    @Published(initialValue: .display) var labelMode: MTMathUILabelMode
    @Published(initialValue: .center) var textAlignment: MTTextAlignment
    @Published var fontSize: CGFloat = MTFontManager().defaultFont().fontSize
    @Published var font: MTFont = MTFontManager().defaultFont()
    @Published var textColor: UIColor = .black
}
