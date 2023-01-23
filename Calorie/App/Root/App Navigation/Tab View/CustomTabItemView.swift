//
//  KineticTabItem.swift
//  kinetic
//
//  Created by Justin Wilkin on 8/10/2022.
//

import SwiftUI

// MARK: - TabItemView
struct CustomTabItemView: View, Identifiable {
    // MARK: Instance properties
    var id: Constants.Tabs
    var icon: Image
    var isSelected: Bool
    
    // MARK: - View properties
    var textColor: Color {
        return isSelected ? Color.black : Color.black.opacity(0.6)
    }
    
    // MARK: View composition
    
    var body: some View {
        VStack {
            icon.resizable()
                .frame(
                    width: 24,
                    height: 24
                )
            
//            Text(id.name)
//                .font(.caption2)
        }
        .foregroundColor(textColor)
        .animation(.easeInOut, value: textColor)
        .frame(
            maxWidth: .infinity
        )
    }
}

// MARK: - Previews
struct KineticTabItem_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabItemView(
            id: Constants.Tabs.rewards,
            icon: Constants.Icons.menu,
            isSelected: true
        )
    }
}
