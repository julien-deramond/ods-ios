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

struct NavigationBarComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "Bars - navigation"
        imageName = "Navigation bars"
        description = "A navigation bar appears at the top of an app screen, below the status bar, and enables navigation through a series of hierarchical screens."
        
        variants = AnyView(NavigationBarVariants())
    }
}

struct NavigationBarVariants: View {

    var body: some View {
        VariantEntryItem(text: "Bar nav - demo",
                         technicalElement: "NavigationView",
                         showThemeSelectionInNavigationBar: false) {
            NavigationBarVariant(model: NavigationBarVariantModel())
        }
    }
}

struct NavigationBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: NavigationBarVariantModel

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        CustomizableVariant {
            NavigationBarVariantContent(model: model)
        } options: {
            NavigationBarVariantOptions(model: model)
        }
    }
}


#if DEBUG
struct NavigationBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    NavigationBarVariants()
                }
            }
        }
    }
}
#endif
