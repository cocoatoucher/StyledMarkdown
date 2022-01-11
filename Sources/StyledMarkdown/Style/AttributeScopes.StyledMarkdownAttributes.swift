//
//  AttributeScopes.StyledMarkdownAttributes.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation

extension AttributeScopes {
    struct StyledMarkdownAttributes: AttributeScope {
        let styleName: StyleNameAttribute
        let linkWithStyleName: LinkWithStyleNameAttribute
        let swiftUI: SwiftUIAttributes
    }
    
    var styledMarkdown: StyledMarkdownAttributes.Type { StyledMarkdownAttributes.self }
}

extension AttributeDynamicLookup {
    subscript<T: AttributedStringKey>(
        dynamicMember keyPath: KeyPath<AttributeScopes.StyledMarkdownAttributes,
        T>
    ) -> T {
        self[T.self]
    }
}

enum StyleNameAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    typealias Value = String
    
    static var name = "style"
}

enum LinkWithStyleNameAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    struct Value: Codable, Hashable {
        let url: URL
        let style: String?
    }
    
    static var name = "link"
}
