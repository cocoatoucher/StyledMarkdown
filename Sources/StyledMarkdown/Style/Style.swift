//
//  Style.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import SwiftUI

public class Style: StyleProtocol {
    
    public var font: SwiftUI.Font?
    
    public var foregroundColor: Color?
    
    public var strikethroughColor: Color?
    
    public var strikethroughStyle: NSUnderlineStyle?
    
    public var underlineColor: Color?
    
    public var underlineStyle: NSUnderlineStyle?
    
    public var kerning: CGFloat?
    
    public var tracking: CGFloat?
    
    public var baselineOffset: CGFloat?
    
    public init(_ handler: ((Style) -> Void)? = nil) {
        handler?(self)
    }
    
    public var modifiers: [StyleModifier] {
        var result: [StyleModifier] = []
        if let font = font {
            result.append(.font(font))
        }
        if let foregroundColor = foregroundColor {
            result.append(.foregroundColor(foregroundColor))
        }
        if let strikethroughColor = strikethroughColor {
            result.append(.strikethroughColor(strikethroughColor))
        }
        if let strikethroughStyle = strikethroughStyle {
            result.append(.strikethroughStyle(strikethroughStyle))
        }
        if let underlineColor = underlineColor {
            result.append(.underline(underlineColor))
        }
        if let underlineStyle = underlineStyle {
            result.append(.underlineStyle(underlineStyle))
        }
        if let kerning = kerning {
            result.append(.kerning(kerning))
        }
        if let tracking = tracking {
            result.append(.tracking(tracking))
        }
        if let baselineOffset = baselineOffset {
            result.append(.baselineOffset(baselineOffset))
        }
        return result
    }
}
