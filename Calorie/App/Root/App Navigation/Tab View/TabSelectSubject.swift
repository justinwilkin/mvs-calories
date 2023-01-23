//
//  TabSelectSubject.swift
//  kinetic
//
//  Created by Justin Wilkin on 4/10/2022.
//

import SwiftUI

/// Tab Select Subject
///
/// The object that owns the tab subject routing.
/// Contains the tab identifier aswell as the destination
struct TabSelectSubject {
    var tab: Constants.Tabs
    var destination: RouteableView
    
    init(tab: Constants.Tabs, destination: some View) {
        self.tab = tab
        self.destination = RouteableView(destination)
    }
}
