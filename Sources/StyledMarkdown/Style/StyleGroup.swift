//
//  StyleGroup.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation

public class StyleGroup {
    
    public var baseStyle: StyleProtocol?
    
    public private(set) var styles: [String: StyleProtocol]
    
    public let styleCustom: ((AttributedString) -> AttributedString)?
    
    public init(
        base: StyleProtocol? = nil,
        _ styles: [String: StyleProtocol] = [:],
        styleCustom: ((AttributedString) -> AttributedString)? = nil
    ) {
        self.baseStyle = base
        self.styles = styles
        self.styleCustom = styleCustom
    }
}
