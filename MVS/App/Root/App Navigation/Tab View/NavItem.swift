//
//  NavItem.swift
//  kinetic
//
//  Created by Justin Wilkin on 27/9/2022.
//

import SwiftUI

struct NavItem {
    struct Tab {
        let identifier: Constants.Tabs
        let icon: Image
        var name: String {
            return identifier.name
        }
    }

    let tab: Tab
    let tabSelectSubject: TabSelectSubject
    
    init(identifier: Constants.Tabs, icon: Image, destination: some View) {
        self.tab = Tab(identifier: identifier, icon: icon)
        self.tabSelectSubject = TabSelectSubject(tab: identifier, destination: destination)
    }
}
