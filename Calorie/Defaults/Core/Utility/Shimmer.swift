//
//  Shimmer.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

/// A view modifier that applies an animated "shimmer" to any view, typically to show that
/// an operation is in progress.
public struct Shimmer: ViewModifier {
    var animation: Animation!
    @State private var phase: CGFloat = 0
    
    /// Initializes his modifier with a custom animation,
    /// - Parameter animation: A custom animation. The default animation is
    ///   `.linear(duration: 1.5).repeatForever(autoreverses: false)`.
    public init(animation: Animation? = nil) {
        self.animation = animation ?? .easeInOut(duration: 1.4).repeatForever(autoreverses: false)
    }

    public func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedMask(phase: phase).animation(animation)
            )
            .onAppear { phase = 0.8 }
    }

    /// An animatable modifier to interpolate between `phase` values.
    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat

        init(phase: CGFloat = 0) {
            self.phase = phase
        }
        
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(
                    GradientMask(phase: phase)
                        .scaleEffect(3)
                )
        }
    }

    /// A slanted, animatable gradient between transparent and opaque to use as mask.
    /// The `phase` parameter shifts the gradient, moving the opaque band.
    struct GradientMask: View {
        let phase: CGFloat
        let centerColor: Color!
        let edgeColor: Color!
        
        init(
            phase: CGFloat
        ) {
            self.phase = phase
            self.centerColor = Color.black
            self.edgeColor = Color.black.opacity(0.6)
        }

        var body: some View {
            LinearGradient(gradient:
                Gradient(stops: [
                    .init(color: edgeColor, location: phase),
                    .init(color: centerColor, location: phase + 0.2),
                    .init(color: edgeColor, location: phase + 0.4),
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

public extension View {
    /// Adds an animated shimmering effect to any view, typically to show that
    /// an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - animation: Provide a custom animation
    @ViewBuilder func shimmering(active: Bool = true, animation: Animation? = nil) -> some View {
        if active {
            modifier(Shimmer(animation: animation))
        } else {
            self
        }
    }
}

// MARK: - Previews
struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack(alignment: .leading) {
                Text(String(repeating: "Shimmer", count: 12))
                    .redacted(reason: .placeholder)
            }.frame(maxWidth: 200)
        }
        .padding()
        .shimmering()
        .previewLayout(.sizeThatFits)
    }
}
