//
//  RoundedSurface.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

struct RoundedShape<Content: View>: View {
    var padding: CGFloat
    var backgroundColor: Color
    var content: Content
    
    init(
        padding: CGFloat = 16,
        backgroundColor: Color = .surface,
        content: () -> Content
    ) {
        self.content = content()
        self.padding = padding
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        content
            .foregroundColor(.onSurface)
            .padding(padding)
            .cornerRadius(16)
            .background(
                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(backgroundColor)
            )
    }
}

// MARK: - Previews
struct RoundedShape_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedShape {
                Text("Rounded shape")
            }
            
            RoundedShape {
                RoundedShape(padding: .zero) {
                    Color.blue
                        .frame(height: 150)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color.background)
    }
}

