//
//  StyleModifier.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import SwiftUI

public enum StyleModifier {
    case font(FontProtocol)
    case foregroundColor(ColorProtocol)
    case strikethroughColor(ColorProtocol)
    case strikethroughStyle(NSUnderlineStyle)
    case underline(ColorProtocol)
    case underlineStyle(NSUnderlineStyle)
    case kerning(CGFloat)
    case tracking(CGFloat)
    case baselineOffset(CGFloat)
}
