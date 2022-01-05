//
//  StyleGroup.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation

public class StyleGroup: StyleProtocol {
    
    public var modifiers: [StyleModifier] = []
    
    public private(set) var styles: [String: StyleProtocol]
    
    public var baseStyle: StyleProtocol?
    
    public init(
        base: StyleProtocol? = nil,
        _ styles: [String: StyleProtocol] = [:]
    ) {
        self.styles = styles
        self.baseStyle = base
    }
}
