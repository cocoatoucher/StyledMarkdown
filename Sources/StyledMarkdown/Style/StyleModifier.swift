//
//  StyleModifier.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import SwiftUI

public enum StyleModifier {
    case font(SwiftUI.Font)
    case foregroundColor(Color)
    case strikethroughColor(Color)
    case strikethroughStyle(NSUnderlineStyle)
    case underline(Color)
    case underlineStyle(NSUnderlineStyle)
    case kerning(CGFloat)
    case tracking(CGFloat)
    case baselineOffset(CGFloat)
}
