//
//  Tab.swift
//  SwiftUI_TabButtonsWithMaskingEffects
//
//  Created by paku on 2023/12/10.
//

import SwiftUI

struct Tab: Identifiable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var name: String
    var image: String
}

var tabs: [Tab] = [
    .init(name: "Iceland", image: "Image1"),
    .init(name: "France", image: "Image2"),
    .init(name: "Brazil", image: "Image3")
]
