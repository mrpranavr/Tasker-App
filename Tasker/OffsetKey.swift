//
//  OffsetKey.swift
//  Tasker
//
//  Created by Pranav R on 02/06/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
