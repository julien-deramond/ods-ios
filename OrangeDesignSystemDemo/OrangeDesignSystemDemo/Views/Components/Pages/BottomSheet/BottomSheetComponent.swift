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
import BottomSheet

struct BottomSheetComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "Sheets: Bottom"
        imageName = "BottomSheet"
        description = "By default, a sheet is modal, presenting a focused experience that prevents users from interacting with the parent view, until they dismiss the sheet. A modal sheet is useful for requesting a specific information or enabling a simple task."
        variants = AnyView(BottomSheetVariants())
    }
}

struct BottomSheetVariants: View {
    var body: some View {
        VariantEntryItem(text: "Expanding", technicalElement: ".odsBottomSheetExpanding()") {
            ExpandingBottomSheetVariantHome(model: BottomSheetVariantModel())
                .navigationTitle("Expanding")
            
        }
        
        VariantEntryItem(text: "Standard", technicalElement: ".odsBottomSheetStandard()") {
            StandardBottomSheetVariant()
                .navigationTitle("Standard")
        }
    }
}

