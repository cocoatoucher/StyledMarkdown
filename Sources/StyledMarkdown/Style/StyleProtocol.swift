//
//  StyleProtocol.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation

public protocol StyleProtocol {
    var modifiers: [StyleModifier] { get }
    
    func add(to source: inout AttributedSubstring)
}

public extension StyleProtocol {
    
    func add(to source: inout AttributedSubstring) {
        for modifier in self.modifiers {
            switch modifier {
            case .font(let font):
                source.font = font
            case .foregroundColor(let color):
                source.foregroundColor = color
            case .strikethroughColor(let color):
                source.strikethroughColor = .init(color)
            case .strikethroughStyle(let style):
                source.strikethroughStyle = style
            case .underline(let color):
                source.underlineColor = .init(color)
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
