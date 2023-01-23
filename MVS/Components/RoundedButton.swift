//
//  RoundedButton.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

public typealias ButtonAction = () -> Void

public struct RoundedButton: View {
    
    // MARK: - Instance Properties
    public var title: String
    public var isEnabled: Bool
    public var isLoading: Bool
    public var action: ButtonAction
    
    // MARK: - Button Lifecycle
        
    /// Custom round button
    ///
    /// Button component that can be reused throughout the application. Actions willl be completed
    /// in the onPress event of the button.
    ///
    /// - Parameters:
    ///   - title: Title text for button.
    ///   - isEnabled: Optional binding of the enabled state of the button to the Store
    ///   - isLoading: Optional binding of the loading state of the button to the Store
    ///   - type: `RoundedButtonType` to determine style of button
    ///   - action: Action closure that will be triggered on click
    public init(
        title: String,
        enabled isEnabled: Bool = true,
        loading isLoading: Bool = false,
        action: @escaping ButtonAction
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        // Forward button action closure to on click
        Button(action: {
            action()
        }) {
            buttonBody
        }
        // Disable our button if it is loading aswell as disabled state
        .disabled(!isEnabled || isLoading)
    }
}

// MARK: - Stateful color properties
extension RoundedButton {
    var textColor: Color {
        .onSurface
    }
    
    var backgroundColor: Color {
        .surface
    }
}

// MARK: - Button Content
extension RoundedButton {
    var buttonBody: some View {
        // Stack our content and progress bar so that our
        // content is centered
        // Using just an HStack here off centers the text
        // when a progress view is visible
        ZStack {
            buttonContent
                .padding()
            
            if isLoading {
                loadingStack
            }
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 54)
        .background(backgroundColor)
        .foregroundColor(textColor)
        .cornerRadius(16, antialiased: true)
    }
    
    var buttonContent: some View {
        Text(title)
            .font(.system(size: 17))
            .bold()
    }
    
    var loadingStack: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(
                        tint: textColor
                    )
                )
                .padding()
        }
    }
}

// MARK: - Autoclosure convenience
extension RoundedButton {
    public init(
        title: String,
        enabled isEnabled: Bool = true,
        loading isLoading: Bool = false,
        action: @autoclosure @escaping ButtonAction
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.action = action
    }
}

// MARK: - Previews
struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        // MARK: Primary buttons
        VStack {
            RoundedButton(
                title: "Primary",
                enabled: true,
                loading: false,
                action: {}
            )
            
            RoundedButton(
                title: "Primary loading",
                enabled: true,
                loading: true,
                action: {}
            )
            
            RoundedButton(
                title: "Primary disabled",
                enabled: false,
                loading: false,
                action: {}
            )
            
            RoundedButton(
                title: "Primary disabled loading",
                enabled: false,
                loading: true,
                action: {}
            )
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.background)
    }
}

