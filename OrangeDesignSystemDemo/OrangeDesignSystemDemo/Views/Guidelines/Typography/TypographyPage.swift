//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import OrangeDesignSystem
import SwiftUI

struct TypographyPageDescription: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    let fontStyles = ODSFontStyle.allCases
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            ForEach(fontStyles, id: \.rawValue) { fontStyle in
                VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                    Text(fontStyle.description)
                        .odsFont(fontStyle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("style: \(fontStyle.rawValue)").font(.system(.caption, design: .monospaced))
                }
                .accessibilityElement()
                .accessibilityLabel("\(fontStyle.description), token name is \(fontStyle.rawValue)")
            }
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.bottom, ODSSpacing.m)
    }
}


// MARK: Font syle description
private extension ODSFontStyle {
    var description: String {
        switch self {
        case .largeTitle:
            return "Large Title"
        case .title1:
            return "Title 1"
        case .title2:
            return "Title 2"
        case .title3:
            return "Title 3"
        case .headline:
            return "Headline"
        case .bodyRegular:
            return "Body (regular)"
        case .bodyBold:
            return "Body (bold)"
        case .callout:
            return "Callout"
        case .subhead:
            return "Subheadline"
        case .footnote:
            return "Footnote"
        case .caption1Regular:
            return "Caption 1 (regular)"
        case .caption1Bold:
            return "Caption 1 (bold)"
        case .caption2:
            return "Caption 2"
        }
    }
}

#if DEBUG
struct FontList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TypographyPageDescription().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
#endif
