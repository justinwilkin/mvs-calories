//
//  View+halfSheet.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 24/1/2023.
//

import SwiftUI

struct HalfSheetModifier<SheetContent: View>: ViewModifier {
    var presentSheet: Binding<Bool>
    @ViewBuilder var sheetContent: () -> SheetContent
    var onDismiss: () -> Void = {}
    @State var contentSize: CGSize = CGSize(width: 1, height: 1)
    
    init(
        _ presentSheet: Binding<Bool>,
        @ViewBuilder sheetContent: @escaping () -> SheetContent,
        onDismiss: @escaping () -> Void = {}
    ) {
        self.presentSheet = presentSheet
        self.sheetContent = sheetContent
        self.onDismiss = onDismiss
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                HalfSheet(
                    presentSheet: presentSheet,
                    contentSize: $contentSize,
                    content: measuredContent,
                    onDismiss: {
                        onDismiss()
                    },
                    delegate: self
                )
            )
    }
    
    var measuredContent: some View {
        ChildGeometryReader(size: $contentSize) {
            sheetContent()
        }
    }
}

extension HalfSheetModifier: HalfSheetDismissDelegate {
    func halfSheetDidDismiss() {
        // Reset our content size otherwise recalculation of height will not happen
        // on next sheet open for new content that is smaller than previous
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            contentSize.height = 1
        }
    }
}

extension View {
    
    public func halfSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        modifier(HalfSheetModifier(isPresented, sheetContent: content, onDismiss: onDismiss))
    }
    
    // MARK: - Autoclosure wrapper
    public func halfSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        onDismiss: @autoclosure @escaping () -> Void
    ) -> some View {
        halfSheet(isPresented: isPresented, content: content, onDismiss: onDismiss)
    }
}

