//
// Created by mizu bai on 2022/1/29.
//

import Foundation

struct EditorThemeModel {
    var themeName: String
    var fontName: String
    var fontSize: CGFloat
    var fontColorHex: String
    var highlight: [HighlightModel]
}

struct HighlightModel {
    var description: String
    var pattern: String
    var fontColorHex: String
}
