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

///
/// <a href="https://system.design.orange.com/0c1af118d/p/47d389-text-fields/b/461794" target="_blank">ODS Text Field</a>.
///
/// The text field component comprises the text field itself, text selection and the edit menu. Some elements are styled and some are native.
///

extension View {
    /// Sets the ods style on __TextField__ and __TextEditor__
    public func odsTextFieldStyle() -> some View {
        modifier(ODSTextFieldStyle())
    }
}

// MARK: - Internal font modifier

///
/// Private modifier to get the theme in environment.
///

private struct ODSTextFieldStyle: ViewModifier {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
            .accentColor(theme.componentColors.accent)
            .padding(.all, ODSSpacing.s)
            .odsFont(.bodyRegular)
            .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8.0))
    }
}