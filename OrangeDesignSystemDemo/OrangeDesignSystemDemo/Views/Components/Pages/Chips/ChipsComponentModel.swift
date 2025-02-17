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

let avatarImage = Image("avatar", bundle: Bundle.main)
let iconImage = Image("iconsFunctionalUiEMIcHeartRecommend", bundle: Bundle.main)

class ChipsVariantModel: ObservableObject {

    // Text only section
    enum TextOnlyChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum TextOnlyRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let textOnlyChips: [ODSChip<TextOnlyChip>]
    let textOnlyRemovableChips: [ODSChip<TextOnlyRemovableChip>]

    @Published var selectedTextOnlyChip: TextOnlyChip?
    @Published var selectedTextOnlyRemovableChip: TextOnlyRemovableChip?

    // with icon section
    enum WithIconChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum WithIconRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let withIconChips: [ODSChip<WithIconChip>]
    let withIconRemovableChips: [ODSChip<WithIconRemovableChip>]

    @Published var selectedWithIconChip: WithIconChip?
    @Published var selectedWithIconRemovableChip: WithIconRemovableChip?

    // with system icon section
    enum WithSystemIconChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum WithSystemIconRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let withSystemIconChips: [ODSChip<WithSystemIconChip>]
    let withSystemIconRemovableChips: [ODSChip<WithSystemIconRemovableChip>]

    @Published var selectedWithSystemIconChip: WithSystemIconChip?
    @Published var selectedWithSystemIconRemovableChip: WithSystemIconRemovableChip?

    // with avatar section
    enum WithAvatarChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum WithAvatarRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let withAvatarChips: [ODSChip<WithAvatarChip>]
    let withAvatarRemovableChips: [ODSChip<WithAvatarRemovableChip>]

    @Published var selectedWithAvatarChip: WithAvatarChip?
    @Published var selectedWithAvatarRemovableChip: WithAvatarRemovableChip?

    init() {
        // Chips with textOnly
        textOnlyChips = [
            ODSChip(.enabled, text: "Enable"),
            ODSChip(.selected, text: "Selected"),
            ODSChip(.disabled, text: "Disabled", disabled: true),
        ]

        selectedTextOnlyChip = .selected

        textOnlyRemovableChips = [
            ODSChip(.enabled, text: "Enable", removable: true),
            ODSChip(.selected, text: "Selected", removable: true),
            ODSChip(.disabled, text: "Disabled", disabled: true, removable: true),
        ]

        selectedTextOnlyRemovableChip = .selected

        // Chips with icon
        withIconChips = [
            ODSChip(.enabled, text: "Enable", thumbnail: .icon(iconImage)),
            ODSChip(.selected, text: "Selected", thumbnail: .icon(iconImage)),
            ODSChip(.disabled, text: "Disabled", thumbnail: .icon(iconImage), disabled: true),
        ]

        selectedWithIconChip = .selected

        withIconRemovableChips = [
            ODSChip(.enabled, text: "Enable", thumbnail: .icon(iconImage), removable: true),
            ODSChip(.selected, text: "Selected", thumbnail: .icon(iconImage), removable: true),
            ODSChip(.disabled, text: "Disabled", thumbnail: .icon(iconImage), disabled: true, removable: true),
        ]

        selectedWithIconRemovableChip = .selected

        // System icons
        withSystemIconChips = [
            ODSChip(.enabled, text: "Enable", thumbnail: .iconSystem(name: "heart")),
            ODSChip(.selected, text: "Selected", thumbnail: .iconSystem(name: "heart")),
            ODSChip(.disabled, text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true),
        ]

        selectedWithSystemIconChip = .selected

        withSystemIconRemovableChips = [
            ODSChip(.enabled, text: "Enable", thumbnail: .iconSystem(name: "heart"), removable: true),
            ODSChip(.selected, text: "Selected", thumbnail: .iconSystem(name: "heart"), removable: true),
            ODSChip(.disabled, text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true, removable: true),
        ]
        selectedWithSystemIconRemovableChip = .selected

        // Chips with avatar
        withAvatarChips = [
            ODSChip(.enabled, text: "Enable", thumbnail: .avatar(avatarImage)),
            ODSChip(.selected, text: "Selected", thumbnail: .avatar(avatarImage)),
            ODSChip(.disabled, text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true),
        ]

        selectedWithAvatarChip = .selected

        withAvatarRemovableChips = [
            ODSChip(.enabled, text: "Enable", thumbnail: .avatar(avatarImage), removable: true),
            ODSChip(.selected, text: "Selected", thumbnail: .avatar(avatarImage), removable: true),
            ODSChip(.disabled, text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true, removable: true),
        ]

        selectedWithAvatarRemovableChip = .selected
    }
}
