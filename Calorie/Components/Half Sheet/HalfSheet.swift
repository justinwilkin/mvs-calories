//
//  HalfSheet.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

protocol HalfSheetDismissDelegate {
    func halfSheetDidDismiss()
}

struct HalfSheet<Content: View>: UIViewControllerRepresentable {
    @Binding var presentSheet: Bool
    var contentSize: Binding<CGSize>
    var content: Content
    var onDismiss: () -> Void
    let controller = UIViewController()
    @State private var isDismissing: Bool = false
    var delegate: HalfSheetDismissDelegate?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if presentSheet && !isDismissing {
            let sheetController = HalfSheetController(
                rootView: content,
                contentSize: contentSize
            )
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else if !isDismissing {
            uiViewController.dismiss(animated: true)
        }
    }
    
    func dismiss() {
        delegate?.halfSheetDidDismiss()
        onDismiss()
        isDismissing = false
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        @State var isPresented: Bool = false
        var parent: HalfSheet
        
        init(parent: HalfSheet) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            // Stop our sheet from dismissing if the user only partially swipes down but lets it back
            // up again
            parent.isDismissing = true
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.dismiss()
        }
    }
}
