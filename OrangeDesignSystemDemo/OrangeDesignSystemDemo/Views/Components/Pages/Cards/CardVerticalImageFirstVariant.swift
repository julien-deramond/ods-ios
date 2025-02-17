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

class CardVerticalImageFirstVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var showSupportingText: Bool
    @Published var buttonCount: Int
    @Published var showAlert: Bool
    var alertText: String = ""
    private let buttonsText = ["Button 1", "Button 2"]

    // =================
    // MARK: Initializer
    // =================

    init() {
        showSubtitle = true
        showSupportingText = true
        buttonCount = 2
        showAlert = false
    }

    // =============
    // MARK: Helpers
    // =============
    
    var cardModel: ODSCardVerticalImageFirstModel {
        ODSCardVerticalImageFirstModel(title: cardExampleTitle,
                               subtitle: showSubtitle ? cardExampleSubtitle : nil,
                               imageSource: cardExampleImage,
                               supportingText: showSupportingText ? cardExampleSupportingText : nil)
    }
    
    func displayAlert(text: String) {
        self.alertText = text
        self.showAlert = true
    }
    
    var button1Text: String? {
        buttonCount >= 1 ? buttonsText[0] : nil
    }

    var button2Text: String? {
        buttonCount >= 2 ? buttonsText[1] : nil
    }

    var numberOfButtons: Int {
        buttonsText.count
    }
}

struct CardVerticalImageFirstVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: CardVerticalImageFirstVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            // Card demonstrator
            ScrollView {
                ODSCardVerticalImageFirst(model: model.cardModel) {
                    if let text = model.button1Text {
                        ODSButton(text: LocalizedStringKey(text), emphasis: .medium) {
                            model.displayAlert(text: "Button 1 clicked")
                        }
                    }
                } buttonContent2: {
                    if let text = model.button2Text {
                        ODSButton(text: LocalizedStringKey(text), emphasis: .medium) {
                            model.displayAlert(text: "Button 2 clicked")
                        }
                    }
                }
                .padding(.horizontal, ODSSpacing.s)
                .padding(.top, ODSSpacing.m)
                .onTapGesture {
                    model.displayAlert(text: "Card container clicked")
                }
            }
            .alert(model.alertText, isPresented: $model.showAlert) {
                Button("close", role: .cancel) {}
            }
        } options: {
            CardVerticalImageFirstVariantOptions(model: model)
        }
    }
}

private struct CardVerticalImageFirstVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: CardVerticalImageFirstVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Subtitle", isOn: $model.showSubtitle)
            Toggle("Text", isOn: $model.showSupportingText)
            
            Stepper("Number of buttons: \(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.numberOfButtons)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
