//
//  RouteableView.swift
//  kinetic
//
//  Created by Justin Wilkin on 3/10/2022.
//

import SwiftUI

struct RouteableView {
    var identifier: UUID
    private var content: AnyView
    init(identifier: UUID  = UUID(), _ content: some View) {
        self.identifier = identifier
        self.content = AnyView(content)
    }
    @ViewBuilder
    func compose() -> some View {
        content
    }
}
