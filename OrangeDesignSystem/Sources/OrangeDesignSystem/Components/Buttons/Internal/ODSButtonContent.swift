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

import SwiftUI

// MARK: Content of ODS buttons
struct ODSButtonContent: View {
    let text: LocalizedStringKey
    let image: Image?
    let variableWidth: Bool

    var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let image = image {
                // /!\ Set to 17 because the size of system font for body is 17
                ODSIcon(image, size: 17)
            }

            Text(text)
                .odsFont(.bodyBold)
        }
        .padding(.all, ODSSpacing.m)
        .frame(minWidth: 50, maxWidth: variableWidth ? nil : .infinity, minHeight: 50)
    }
}

#if DEBUG
struct ODSButtonContent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ODSButtonContent(text: "Text", image: Image(systemName: "wrench"), variableWidth: true)
                .background(.red)
            ODSButtonContent(text: "Text", image: Image(systemName: "wrench"), variableWidth: false)
                .background(.blue)
            ODSButtonContent(text: "Text", image: Image(systemName: "wrench"), variableWidth: true)
                .background(.red)
        }
        .background(.green)
    }
}
#endif
