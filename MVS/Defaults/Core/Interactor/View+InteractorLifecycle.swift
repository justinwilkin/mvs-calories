//
//  View+StoreLifecycle.swift
//  kinetic
//
//  Created by Justin Wilkin on 27/9/2022.
//

import SwiftUI

extension View {
    public func registerInteractorLifecycle(_ interactor: any PInteractor) -> some View {
        self.onAppear { interactor.update() }
            .onDisappear { interactor.cancel() }
    }
}
