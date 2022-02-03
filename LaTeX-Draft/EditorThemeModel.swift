//
// Created by mizu bai on 2022/1/29.
//

import UIKit

struct EditorThemeModel: Codable {
    var themeName: String
    var fontName: String
    var fontSize: CGFloat
    var fontColorHex: String
    var highlightRules: [HighlightModel]
}

struct HighlightModel: Codable {
    var description: String
    var pattern: String
    var fontColorHex: String
}
