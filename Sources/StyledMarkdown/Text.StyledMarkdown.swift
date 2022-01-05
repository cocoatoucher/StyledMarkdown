//
//  Text.StyledMarkdown.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation
import SwiftUI

extension Text {
    
    /// Creates a Text with given markdown localized key and a style group.
    /// - Parameters:
    ///   - localizedKey: Localized key for the markdown string.
    ///   - styleGroup: Style group to be used to apply styling on the markdown.
    init(
        _ localizedKey: String.LocalizationValue,
        styleGroup: StyleGroup
    ) {
        let attributedString = AttributedString(
            localized: localizedKey,
            including: \.styledMarkdown
        )
        self = Text(
            Self.annotateStyles(
                from: attributedString,
                styleGroup: styleGroup
            )
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
                if let style = styleGroup.styles[link.style] {
                    style.add(
                        to: &attrString[currentRange.lowerBound ..< currentRange.upperBound]
                    )
                }
                
                attrString[currentRange.lowerBound ..< currentRange.upperBound].link = link.url
            }
        }
        return attrString
    }
    
}

struct Text_StyledMarkdown_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            
            VStack {
                Text("Changing order in languages")
                    .padding(.bottom, 10.0)
                
                Text(
                    "^[Fast](style: 'italic') & Delicious Food",
                    styleGroup: languageStyleGroup
                )
                Divider()
                Text(
                    "Comida ^[rápida](style: 'italic') y deliciosa",
                    styleGroup: languageStyleGroup
                )
            }
            .previewLayout(.sizeThatFits)
            .previewInterfaceOrientation(.portraitUpsideDown)
            
            Text(
                "A styled link -> ^[styled link](link: {url: 'http://www.example.com', style: 'link'})",
                styleGroup: linkStyleGroup
            )
                .previewLayout(.sizeThatFits)
            
            Text(
                "regular ^[italic&striked](style: 'italicAndStriked')  ^[underlined](style: 'underlined')",
                styleGroup: firstStyleGroup
            )
                .previewLayout(.sizeThatFits)
            
            Text(
                "regular ^[more kerning](style: 'moreKerning') ^[more tracking](style: 'moreTracking')",
                styleGroup: secondStyleGroup
            )
                .frame(maxWidth: 150.0)
                .previewLayout(.sizeThatFits)
            
            Text(
                "regular ^[more baseline offset](style: 'moreBaselineOffset')",
                styleGroup: thirdStyleGroup
            )
                .previewLayout(.sizeThatFits)
        }
        .preferredColorScheme(.dark)
    }
    
    static var languageStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .white
        }
        
        let italicStyle = Style { style in
            style.font = Font.italic(.system(size: 20))()
            style.foregroundColor = .blue
        }
        
        return .init(
            base: normalStyle,
            [
                "italic": italicStyle
            ]
        )
    }
    
    static var linkStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .white
        }
        
        let linkStyle = Style { style in
            style.foregroundColor = .white
            style.underlineColor = .yellow
            style.underlineStyle = .single
        }
        
        return .init(
            base: normalStyle,
            [
                "link": linkStyle
            ]
        )
    }
    
    static var firstStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .white
        }
        
        let italicAndStrikedStyle = Style { style in
            style.font = Font.italic(.system(size: 20))()
            style.foregroundColor = .blue
            style.strikethroughColor = .yellow
            style.strikethroughStyle = .single
        }
        
        let underlinedStyle = Style { style in
            style.font = Font.bold(.system(size: 20))()
            style.foregroundColor = .yellow
            style.underlineColor = .red
            style.underlineStyle = .single
        }
        
        return .init(
            base: normalStyle,
            [
                "italicAndStriked": italicAndStrikedStyle,
                "underlined": underlinedStyle
            ]
        )
    }
    
    static var secondStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .white
        }
        
        let moreKerning = Style { style in
            style.font = Font.italic(.system(size: 20))()
            style.kerning = 10.0
        }
        
        let moreTracking = Style { style in
            style.font = Font.bold(.system(size: 20))()
            style.tracking = 20.0
        }
        
        return .init(
            base: normalStyle,
            [
                "moreKerning": moreKerning,
                "moreTracking": moreTracking
            ]
        )
    }
    
    static var thirdStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .white
        }
        
        let moreBaselineOffset = Style { style in
            style.font = Font.italic(.system(size: 20))()
            style.baselineOffset = 10.0
        }
        
        return .init(
            base: normalStyle,
            [
                "moreBaselineOffset": moreBaselineOffset
            ]
        )
    }
}
