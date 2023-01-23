//
//  AppRootView.swift
//  Shared
//
//  Created by Justin Wilkin on 25/6/2022.
//

import SwiftUI

struct AppRootView: View {
    // MARK: - Injection
    @Inject(\.appRootInteractor) var interactor: any PAppRootInteractor
    @Store(\.routerStore) private var router: RouterStore
    
    // MARK: - View construction
    var body: some View {
        // MARK: Page root
        ZStack(alignment: .top) {
            // Background color
            Color.white
            
            // Compose our subject to our rootView
            router.rootViewSubject?.compose()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .registerInteractorLifecycle(interactor)
        
        // MARK: Full sheet
        // Global sheet subject for presenting full sheet overlay
        .fullScreenCover(isPresented: $router.shouldShowFullSheetOverlay) {
            router.fullSheetOverlaySubject?.compose()
        }
        
        // MARK: Modal sheet
        // Global sheet subject for presenting modal sheet overlays
        .sheet(isPresented: $router.shouldShowModalSheetOverlay) {
            router.modalSheetOverlaySubject?.compose()
        }
    }
}

// MARK: - Previews
struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
    }
}
