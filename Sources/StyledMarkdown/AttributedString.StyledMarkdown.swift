//
//  AttributedString.StyledMarkdown.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation

public extension AttributedString {
    /// Creates an AttributedString with given markdown localized key and a style group.
    /// - Parameters:
    ///   - localized: Localized key for the markdown string.
    ///   - styleGroup: Style group to be used to apply styling on the markdown.
    init(
        localized: String.LocalizationValue,
        styleGroup: StyleGroup
    ) {
        let attributedString = AttributedString(
            localized: localized,
            including: \.styledMarkdown
        )
        self = Self.annotateStyles(
            from: attributedString,
            styleGroup: styleGroup
        )
    }
    
    /// Creates an AttributedString with given markdown string and a style group.
    /// Due to an iOS bug, watch out for your markdown string to not be a localization key
    /// as well which is referencing another string value.
    /// - Parameters:
    ///   - markdown: Markdown string.
    ///   - styleGroup: Style group to be used to apply styling on the markdown.
    init(
        markdown: String,
        styleGroup: StyleGroup
    ) {
        // Here we are supposed to use `.init(markdown:including:)`
        // of AttributedString
        // but it has a bug, radar opened and waiting for a fix.
        let attributedString = AttributedString(
            localized: String.LocalizationValue(markdown),
            including: \.styledMarkdown
        )
        self = Self.annotateStyles(
            from: attributedString,
            styleGroup: styleGroup
        )
    }
    
    // MARK: Private functions
    
    private static func annotateStyles(
        from source: AttributedString,
        styleGroup: StyleGroup
    ) -> AttributedString {
        
        var attrString = source
        
        for run in attrString.runs {
            
            let currentRange = run.range
            
            styleGroup.baseStyle?.add(
                to: &attrString[currentRange.lowerBound ..< currentRange.upperBound]
            )
            
            // Regular style
            if let styleName = run.styleName {
                if let style = styleGroup.styles[styleName] {
                    style.add(
                        to: &attrString[currentRange.lowerBound ..< currentRange.upperBound]
                    )
                }
            }
            
            // Link style
            if let link = run.linkWithStyleName {
                if
                    let linkStyleName = link.style,
                    let style = styleGroup.styles[linkStyleName]
                {
                    style.add(
                        to: &attrString[currentRange.lowerBound ..< currentRange.upperBound]
                    )
                }
                
                attrString[currentRange.lowerBound ..< currentRange.upperBound].link = link.url
            }
        }
        
        if let styleCustom = styleGroup.styleCustom {
            attrString = styleCustom(source)
        }
        
        return attrString
    }
}
