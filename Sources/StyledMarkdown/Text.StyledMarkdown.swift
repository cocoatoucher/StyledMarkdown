//
//  Text.StyledMarkdown.swift
//  StyledMarkdown
//
//  Created by cocoatoucher on 2022-01-04.
//

import Foundation
import SwiftUI

public extension Text {
    
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
            styleGroup: styleGroup
        )
        self = Text(attributedString)
    }
    
    /// Creates a Text with given markdown string and a style group.
    /// Due to an iOS bug, watch out for your markdown string to not be a localization key
    /// as well which is referencing another string value.
    /// - Parameters:
    ///   - markdown: Markdown string.
    ///   - styleGroup: Style group to be used to apply styling on the markdown.
    init(
        markdown: String,
        styleGroup: StyleGroup
    ) {
        let attributedString = AttributedString(
            markdown: markdown,
            styleGroup: styleGroup
        )
        self = Text(attributedString)
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
            
            Text(
                "Rainbow",
                styleGroup: rainbowStyleGroup
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
    
    static var rainbowStyleGroup: StyleGroup {
        return .init(
            styleCustom: { source in
                var attrString = source
                for run in attrString.runs {
                    let currentRange = run.range
                    var index = currentRange.lowerBound
                    let rainbow: [Color] = [
                        .blue,
                        .teal,
                        .red,
                        .gray,
                        .yellow,
                        .orange,
                        .purple
                    ]
                    var colorCounter: Int = 0
                    while index < currentRange.upperBound {
                        let nextIndex = attrString.characters.index(index, offsetBy: 1)
                        attrString[index ..< nextIndex].foregroundColor = rainbow[colorCounter]
                        colorCounter += 1
                        if colorCounter >= rainbow.count {
                            colorCounter = 0
                        }
                        index = nextIndex
                    }
                }
                return attrString
            }
        )
    }
}
