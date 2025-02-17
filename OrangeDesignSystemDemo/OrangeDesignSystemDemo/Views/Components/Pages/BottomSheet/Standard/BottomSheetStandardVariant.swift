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

struct StandardBottomSheetVariant: View {
    
    // =======================
    // MARK: Stored properties
    // =======================

    @State var selectedRecipe: Recipe? = RecipesListSelection.receipes.first
    @State var isOpen: Bool = false
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        pageContent
            .odsBottomSheetStandard(isOpen: $isOpen, title: "Recipes", icon: Image(systemName: "chevron.down")) {
                RecipesListSelection(selectedRecipe: $selectedRecipe)
            }
    }
    
    // ============
    // MARK: Helper
    // ============

    @ViewBuilder
    private var pageContent: some View {
        if let recipe = selectedRecipe {
                let cardModel = ODSCardVerticalImageFirstModel(title: recipe.title,
                                                               subtitle: recipe.subtitle,
                                                               imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                                                               supportingText: recipe.description)
                
            ScrollView {
                ODSCardVerticalImageFirst(model: cardModel).padding(.horizontal, ODSSpacing.s)
            }
        } else {
            EmptyView()
        }
    }
}

struct RecipesListSelection: View {
    
    // =======================
    // MARK: Stored properties
    // =======================

    private let selectedRecipe: Binding<Recipe?>
    private let listItemModels: [ODSListStandardItemModel]
    fileprivate static let receipes: [Recipe] = Array(RecipeBook.shared.recipes.prefix(4))
    
    // =================
    // MARK: Initializer
    // =================

    init(selectedRecipe: Binding<Recipe?>) {
        self.selectedRecipe = selectedRecipe
        self.selectedRecipe.wrappedValue = Self.receipes.first
        self.listItemModels = Self.receipes.map { recipe in
            ODSListStandardItemModel(title: recipe.title, leadingIcon: .icon(Image(recipe.iconName)))
        }
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: 0) {
            ForEach(self.listItemModels, id: \.title) { listItemModel in
                ODSListStandardItem(model: listItemModel)
                    .padding(.horizontal, ODSSpacing.s)
                    .listRowSeparator(Visibility.visible)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        selectedRecipe.wrappedValue = Self.receipes.first { $0.title == listItemModel.title }
                    }
            }
        }
    }
}
