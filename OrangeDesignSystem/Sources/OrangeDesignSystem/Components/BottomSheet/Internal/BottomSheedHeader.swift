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

import SwiftUI

struct BottomSheedHeader: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let subtitle: String?
    let icon: Image?
    let applyRotation: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: ODSSpacing.none) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 55, height: 4, alignment: .center)
                    .padding(.top, ODSSpacing.s)
                    .padding(.bottom, ODSSpacing.xs)

                VStack(spacing: ODSSpacing.none) {
                    HStack(spacing: ODSSpacing.xs) {
                        icon?
                            .foregroundColor(.primary)
                            .accessibility(hidden: true)
                            .odsFont(.headline)
                            .animation(.linear, value: applyRotation)
                            .rotationEffect(.degrees(applyRotation ? 180 : 0))

                        VStack(alignment: .leading, spacing: ODSSpacing.none) {
                            Text(title)
                                .odsFont(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if let subtitle = self.subtitle {
                                Text(subtitle)
                                    .odsFont(.subhead)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.leading, ODSSpacing.s)
                    .padding(.trailing, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.s)
                }
            }
            .background(Color(.systemGray6))
            .padding(.bottom, 10)
            .cornerRadius(10)
            .shadow(color: Color(UIColor.systemGray), radius: 4)
            .padding(.bottom, -10)
            .padding(.top, 10)
            .mask(Rectangle().padding(.top, -40))
            
            Divider()
        }
    }
}

#if DEBUG
struct HeaderPreviewProvider_Previews: PreviewProvider {

    struct AnimatinoExample: View {
        @State var applyRotation = false

        var body: some View {
            BottomSheedHeader(title: "Rotation: \(applyRotation ? "Yes" : "No")", subtitle: nil, icon: Image(systemName: "chevron.up"), applyRotation: applyRotation)
                .onTapGesture {
                    applyRotation.toggle()
                }

            ODSButton(text: LocalizedStringKey(applyRotation ? "Remove Rotation" : "Apply Rotation"), emphasis: .highest) {
                applyRotation.toggle()
            }
        }
    }

    static var previews: some View {
        VStack(spacing: 50) {
            VStack {
                Text("Title and Subtile")
                    .odsFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                BottomSheedHeader(title: "Title", subtitle: "Subtitle", icon: nil, applyRotation: false)
            }

            VStack {
                Text("Title and icon (without rotation)")
                    .odsFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                BottomSheedHeader(title: "Title", subtitle: nil, icon: Image(systemName: "chevron.down"), applyRotation: false)
            }

            VStack {
                Text("Title and icon (with rotation)")
                    .odsFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                BottomSheedHeader(title: "Title", subtitle: nil, icon: Image(systemName: "chevron.down"), applyRotation: true)
            }

            VStack {
                Text("Title and icon (animated rotation)")
                    .odsFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                AnimatinoExample()
            }
        }
        .padding(.horizontal, 16)
    }
}
#endif
