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

/// A thumbnail can be added on the right side of a chip.
/// - Icon is a simple image with only one color
/// - Avatar is the a more complex image like contact photo.
public enum ODSChipThumbnail {
    case icon(Image)
    case iconSystem(name: String)
    case avatar(Image)
}

/// <a href="https://zeroheight.com/3b9fee398/p/67a9e8-chips/b/604d19" target="_blank">ODS Chips</a>.
///
/// Chips are small components containing a number of elements that represent a calendar event or contact.

public typealias ODSChip<Value> = ODSChipPicker<Value>.ODSChipModel where Value: Hashable

/// Create a picker by providing the selection type with a binding to get selected element(s).
/// An additonnal title can be added above the Picker.
///
public struct ODSChipPicker<Value>: View where Value: Hashable {

    /// The chip element description.
    ///  - Parameters
    ///     - value: The value of the chip
    ///     - text: Text to display in the chip.
    ///     - thumbnail: Optional leading thumbnail.
    ///     - disabled: When disabled, chip will not respond to user input. It will also appear
    ///       visually disabled and disabled to accessibility services.
    ///     - removable: To add the remove cross to allow a chip to be removed from a list of chips.

    public struct ODSChipModel {

        let value: Value
        let text: String
        let thumbnail: ODSChipThumbnail?
        let disabled: Bool
        let removable: Bool

        public init(_ value: Value, text: String, thumbnail: ODSChipThumbnail? = nil, disabled: Bool = false, removable: Bool = false)
        {
            self.value = value
            self.text = text
            self.thumbnail = thumbnail
            self.disabled = disabled
            self.removable = removable
        }
    }

    /// Creates a picker that manage a single selection.
    ///
    /// - Parameters:
    ///     - title: Optional title above the picker
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - allowZeroSelection: If set to true mens that no chip can be selected, otherwise almost one chip is always selected
    ///     - chips: All chips describing elements to be displayed.

    public init(title: String? = nil, selection: Binding<Value?>, allowZeroSelection: Bool = false, chips: [ODSChipModel]) {
        self.title = title
        self.chips = chips
        self.allowZeroSelection = allowZeroSelection

        singleSelection = selection
        multipleSelection = nil
    }

    /// Creates a picker that manage a multiple selection.
    ///
    /// - Parameters:
    ///     - title: Optional title above the picker
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - allowZeroSelection: If set to true mens that no chip can be selected, otherwise almost one chip is always selected
    ///     - chips: All chips describing elements to be displayed.
    public init(title: String? = nil, selection: Binding<[Value]>, allowZeroSelection: Bool = false, chips: [ODSChipModel]) {
        self.title = title
        self.chips = chips
        self.allowZeroSelection = allowZeroSelection
        singleSelection = nil
        multipleSelection = selection
    }

    typealias SingleSelection = Binding<Value?>
    typealias MultipleSelection = Binding<[Value]>

    let title: String?
    let chips: [ODSChipModel]
    let singleSelection: SingleSelection?
    let multipleSelection: MultipleSelection?
    let allowZeroSelection: Bool

    @State var textHeight: CGFloat = 30.0

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title).odsFont(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {

                    HStack(spacing: 8) {
                        ForEach(chips, id: \.value) { chip in
                            Button {
                                handleSelection(for: chip)
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    if let thumbnail = chip.thumbnail {
                                        ChipThumbnail(selected: isSelected(chip),
                                                      thumbnail: thumbnail,
                                                      height: textHeight)
                                    }

                                    Text(chip.text)
                                        .odsFont(.subhead)
                                        .tint(isSelected(chip) ? .black : .primary)
                                        .padding(.vertical, 6)
                                        .padding(.leading, textLeadingPadding(for: chip))
                                        .padding(.trailing, false /* chip.removable*/ ? 8 : 16)
                                        .readSize { size in
                                            textHeight = size.height
                                        }

                                    if chip.removable {
                                        ChipRemoveLabel(height: textHeight, selected: isSelected(chip))
                                            .highPriorityGesture(TapGesture().onEnded {
                                                // TODO:
                                                print("TODO")
                                                //                                            self.onChipRemoved(chip)
                                            })
                                    }
                                }
                            }
                            .background(background(for: chip))
                            .clipShape(Capsule())
                            .disabled(chip.disabled)
                        }
                    }
                    .padding(.trailing, 10)
                    .padding(.leading, 16)
                }
            }
        }
    }

    func textLeadingPadding(for chip: ODSChipModel) -> CGFloat {
        switch chip.thumbnail {
        case .icon: return 8.0
        case .avatar: return isSelected(chip) ? 8 : 6
        case .iconSystem: return 8
        case .none: return 16.0
        }
    }

    @ViewBuilder func background(for chip: ODSChipModel) -> some View {
        if isSelected(chip) {
            Capsule().foregroundColor(ODSColor.coreOrange.color)
        } else {
            Capsule().stroke(lineWidth: 1)
        }
    }

    func isSelected(_ chip: ODSChipModel) -> Bool {

        if let singleSelection = singleSelection {
            return chip.value == singleSelection.wrappedValue
        }

        if let multipleSelection = multipleSelection {
            return multipleSelection.wrappedValue.contains(where: { chip.value == $0 })
        }

        return false
    }

    func handleSelection(for chip: ODSChipModel) {
        if let singleSelection = singleSelection {
            handle(singleSelection, for: chip)
        } else {
            if let multipleSelection = multipleSelection {
                handle(multipleSelection, for: chip)
            }
        }
    }

    func handle(_ singleSelection: SingleSelection, for chip: ODSChipModel) {
        if singleSelection.wrappedValue == chip.value {
            if allowZeroSelection {
                singleSelection.wrappedValue = nil
            }
        } else {
            singleSelection.wrappedValue = chip.value
        }
    }

    func handle(_ multipleSelection: MultipleSelection, for chip: ODSChipModel) {
        if let index = multipleSelection.wrappedValue.firstIndex(where: { $0 == chip.value }) {
            if multipleSelection.count != 1 || allowZeroSelection {
                multipleSelection.wrappedValue.remove(at: index)
            }
        } else {
            multipleSelection.wrappedValue.append(chip.value)
        }
    }
}

struct ChipThumbnail: View {
    let selected: Bool
    let thumbnail: ODSChipThumbnail
    let height: CGFloat

    var body: some View {
        switch thumbnail {
        case let .avatar(image):
            if selected {
                ChipSelectedAvatar(height: height)
            } else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: height - 6, height: height - 6, alignment: .center)
                    .clipShape(Circle())
                    .padding(.leading, 4)
            }
        case let .icon(image):
            image
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .tint(selected ? .black : .primary)
                .frame(width: height - 9, height: height - 9, alignment: .center)
                .padding(.leading, 7)

        case let .iconSystem(name):
            Image(systemName: name)
                .tint(selected ? .black : .primary)
                .padding(.leading, 8)
        }
    }
}

struct ChipSelectedAvatar: View {
    let height: CGFloat

    var body: some View {
        Image("iconsFunctionalUiEMIcFormTick", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .tint(ODSColor.coreOrange.color)
            .background(Color.black)
            .frame(width: height - 6, height: height - 6, alignment: .center)
            .clipShape(Circle())
            .padding(.leading, 4)
    }
}

struct ChipRemoveLabel: View {

    let height: CGFloat
    let selected: Bool

    var body: some View {
        Image("Close", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .tint(selected ? .black : .primary)
            .frame(width: height - 11, height: height - 11, alignment: .center)
            .padding(.trailing, 7.0)
    }
}

#if DEBUG
struct ODSChips_Previews: PreviewProvider {

    enum ChipsTest: Int, CaseIterable {
        case title1 = 1
        case title2
        case removable1
        case removabele2
        case disabled

        var odsChip: ODSChip<ChipsTest> {
            switch self {
            case .title1:
                return ODSChip(self, text: "Title 1")
            case .title2:
                return ODSChip(self, text: "Title 2", thumbnail: .iconSystem(name: "heart"))
            case .removable1:
                return ODSChip(self, text: "Removable 1", removable: true)
            case .removabele2:
                return ODSChip(self, text: "Removable 2", thumbnail: .iconSystem(name: "heart"), removable: true)
            case .disabled:
                return ODSChip(self, text: "Disabled", disabled: true)
            }
        }
    }

    struct ODSChipPickerTest: View {
        @State var selectedChip: ChipsTest?
        @State var selectedChips: [ChipsTest] = []
        let allowZeroSelection = true

        let chips = ChipsTest.allCases.map { $0.odsChip }

        var body: some View {
            VStack {
                VStack(spacing: 10) {
                    VStack(spacing: 10) {
                        ODSChipPicker(title: "Single selection",
                                      selection: $selectedChip,
                                      allowZeroSelection: allowZeroSelection,
                                      chips: chips)
                        Text("selected Chip : \(selectedChip?.odsChip.text ?? "")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 0)
                    .padding(.bottom, 20)
                    .background(ODSColor.supportingGreen100.color)

                    VStack(spacing: 10) {
                        ODSChipPicker(title: "Multiple selection",
                                      selection: $selectedChips,
                                      allowZeroSelection: allowZeroSelection,
                                      chips: chips)

                        Text("Selected Chip : \(self.selectedChipsText)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 16)
                    }
                    .padding(.horizontal, 0)
                    .padding(.bottom, 20)
                    .background(ODSColor.supportingGreen100.color)
                }
            }
        }

        var selectedChipsText: String {
            return selectedChips.reduce(into: "") { result, chip in
                result = "\(result), \(chip.odsChip.text)"
            }
        }
    }

    static var previews: some View {
        ODSChipPickerTest()
    }
}
#endif
