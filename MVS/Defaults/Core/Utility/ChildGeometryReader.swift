//
//  ChildGeometryReader.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 24/1/2023.
//

import SwiftUI

public struct ChildGeometryReader<Content: View>: View {
    @Binding var size: CGSize
    
    private struct SizeKey: PreferenceKey {
        static var defaultValue: CGSize { CGSize(width: 1, height: 1) }
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
    
    public init(size: Binding<CGSize>, content: () -> Content) {
        self._size = size
        self.content = content()
    }
    
    // MARK: Reader Defaults
    @ViewBuilder let content: Content

    // MARK: - Content
    public var body: some View {
        content
            // Using background restricts our geometry reader to being greedy only to the
            // intrinsic size of content
            .background(GeometryReader { proxy in
                // Store our determined dimension in a preference for use up the viewstack
                Color.clear
                    .preference(
                        key: SizeKey.self,
                        value: proxy.size
                    )
                    // notify of the dimension change
                    .onPreferenceChange(SizeKey.self) { newSize in
                        size = newSize
                    }
            })
    }
}
