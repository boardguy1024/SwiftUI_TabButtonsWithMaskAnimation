//
//  Extensions.swift
//  SwiftUI_TabButtonsWithMaskingEffects
//
//  Created by paku on 2023/12/10.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func offsetX(changed: @escaping (CGFloat) -> Void) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self, perform: { value in
                            changed(value)
                        })
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
