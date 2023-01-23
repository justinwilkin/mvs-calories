//
//  HalfSheetController.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 24/1/2023.
//

import SwiftUI

class HalfSheetController<Content: View>: UIHostingController<Content> {
    @Binding var contentSize: CGSize
    var lastHeight: CGFloat
    var hasLaidOut = false
    
    init(rootView: Content, contentSize: Binding<CGSize>) {
        self._contentSize = contentSize
        lastHeight = contentSize.height.wrappedValue
        super.init(rootView: rootView)
    }

    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        // presentation controls setup
        if let controller = presentationController as? UISheetPresentationController {
            controller.preferredCornerRadius = 16
            controller.detents = .height(self.contentSize.height)
            
            // Hide our grabber
            controller.prefersGrabberVisible = false
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard !hasLaidOut else { return } // Only change detents if it hasnt laid out prior
        if contentSize.height > lastHeight { hasLaidOut.toggle() }
        
        if let controller = presentationController as? UISheetPresentationController {
            controller.detents = .height(self.contentSize.height)
        }
    }
}

extension [UISheetPresentationController.Detent] {

    static func height(_ height: CGFloat) -> [UISheetPresentationController.Detent] {
        // TODO: Refactor when iOS 16 minimum
        if #available(iOS 16.0, *) {
            return [UISheetPresentationController.Detent.custom(resolver: { _ in height })]
        } else {
            if height > 480 {
                return [UISheetPresentationController.Detent.large()]
            }
            return [UISheetPresentationController.Detent.medium()]
        }
    }
}
