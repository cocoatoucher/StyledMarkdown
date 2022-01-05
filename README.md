<p align="center">
<img src="Docs/logo.png" width="300" max-width="80%" alt="glide"/>
</p>

<p align="center">
iOS 15.0 / macOS 12.0 / tvOS 15.0 / watchOS 8.0
</p>

StyledMarkdown is a mini library that lets you define custom styles in code and use them in your localized markdown strings.

```
let normalStyle = Style { style in
	style.font = .subheadline
	style.foregroundColor = .red
}

let boldStyle = Style { style in
	style.font = Font.italic(.system(size: 20))()
	style.foregroundColor = .blue
}

let myStyleGroup = StyleGroup(
	base: normalStyle,
	[
		"bold": boldStyle
	]
)

Text(
	"Hey ^[buddy](style: 'bold')",
	styleGroup: myStyleGroup
)
```

A custom `Text` initializer with custom `AttributedStringKey`s are used to achieve this outcome.

***The idea of StyleGroup and named Styles comes directly from [`SwiftRichString` library by `Daniele Margutti` on GitHub](https://github.com/malcommac/SwiftRichString). Some of the code from there is also used in this package.***

### Limitation

Currently there is a bug with `.init(markdown:including:)` initialiser of `AttributedString`. This initializer ignores custom `AttributedStringKey`s used in this library while creating the final string. Due to this, right now it is not possible to style any markdown string, but only localized keys. Radar reported, a new initialiser will be added once that is fixed.

## Examples
<p align="center">
<img src="Docs/examples.png" width="400" max-width="80%" alt="glide devices"/>
</p>

## Supported modifiers

#### font(*SwiftUI.Font*)
#### foregroundColor(*Color*)
#### strikethrough(*Color*)
#### strikethroughStyle(*NSUnderlineStyle*)
#### underline(*Color*)
#### underlineStyle(*NSUnderlineStyle*)
#### kerning(*CGFloat*)
#### tracking(*CGFloat*)
#### baselineOffset(*CGFloat*)

### 🔗 Links

You can add links inside your strings using the custom `link` `AttributedStringKey`:
`^[styled link](link: {url: 'http://www.example.com', style: 'linkStyle'})`

### 🎆 Images (not supported)

It is currently not supported to include `Image` elements within `AttributedString`.
