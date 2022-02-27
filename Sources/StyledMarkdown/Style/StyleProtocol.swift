//
//  StyleProtocol.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation
import SwiftUI

public protocol StyleProtocol {
    var modifiers: [StyleModifier] { get }
    
    func add(to source: inout AttributedSubstring)
}

public extension StyleProtocol {
    
    func add(to source: inout AttributedSubstring) {
        for modifier in modifiers {
            switch modifier {
            case .font(let font):
                if let uiFont = font as? UIFont {
                    source.font = uiFont
                } else {
                    source.font = font as? SwiftUI.Font
                }
            case .foregroundColor(let color):
                if let uiColor = color as? UIColor {
                    source.foregroundColor = uiColor
                } else {
                    source.foregroundColor = color as? SwiftUI.Color
                }
            case .strikethroughColor(let color):
                if let uiColor = color as? UIColor {
                    source.strikethroughColor = uiColor
                } else if let color = color as? SwiftUI.Color {
                    source.strikethroughColor = .init(color)
                } else {
                    source.strikethroughColor = nil
                }
            case .strikethroughStyle(let style):
                source.strikethroughStyle = style
            case .underline(let color):
                if let uiColor = color as? UIColor {
                    source.underlineColor = uiColor
                } else if let color = color as? SwiftUI.Color {
                    source.underlineColor = .init(color)
                } else {
                    source.underlineColor = nil
                }
            case .underlineStyle(let style):
                source.underlineStyle = style
            case .kerning(let kerning):
                source.kern = kerning
            case .tracking(let tracking):
                source.tracking = tracking
            case .baselineOffset(let baselineOffset):
                source.baselineOffset = baselineOffset
            }
        }
    }
    
}
