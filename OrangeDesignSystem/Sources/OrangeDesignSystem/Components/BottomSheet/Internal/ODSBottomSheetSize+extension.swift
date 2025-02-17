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
import BottomSheet

extension ODSBottomSheetSize {
    var position: BottomSheetPosition {
        switch self {
        case .hidden:
            return .hidden
        case .small:
            return .dynamicBottom
        case .medium:
            return .relative(0.5)
        case .large:
            return .relativeTop(0.975)
        }
    }

    public init(from position: BottomSheetPosition) {
        switch position {
        case .hidden:
            self = .hidden
        case .dynamicBottom:
            self = .small
        case .relative(let ratio) where ratio == 0.5:
            self = .medium
        default:
            self = .large
        }
    }
}

#if DEBUG
extension BottomSheetPosition {
    public var description: String {
        switch self {
        case .absolute(let s):
            return "absolute (\(s))"
        case .hidden:
            return "Hidden"
        case .dynamicBottom:
            return "dynamicBottom"
        case .dynamic:
            return "dynamic"
        case .dynamicTop:
            return "dynamicTop"
        case .relativeBottom(let s):
            return "dynamicBottom(\(s))"
        case .relative(let s):
            return "relative(\(s))"
        case .relativeTop(let s):
            return "relativeTop(\(s))"
        case .absoluteBottom(let s):
            return "absoluteBottom(\(s))"
        case .absoluteTop(let s):
            return "absoluteTop(\(s))"
        }
    }
}
#endif
