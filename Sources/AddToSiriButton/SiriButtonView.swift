//
//  SiriButtonView.swift
//  Stuff To Get (iOS)
//
//  Created by Kevin Mullins on 6/24/21.
//  From: https://www.reddit.com/r/SwiftUI/comments/fhh1fw/add_to_siri_button_with_swiftui/
//

import SwiftUI
import Intents

/**
 Creates a **Siri Voice Shortcut Button** that can be displayed in SwiftUI.
 
 ## Example:
 ```swift
 // For an intent
 let intent = MyIntent()
 SiriButtonView(intent: intent)
 
 // For an existing Voice Shortcut
 SiriButtonView(voiceShortcut: myVoiceShortcut)
 ```
 */
struct SiriButtonView: UIViewControllerRepresentable {
    // MARK: - Properties
    /// The intent to show the button for
    var intent: INIntent? = nil
    
    /// The Voice Shortcut to show the button for.
    var voiceShortcut: INVoiceShortcut? = nil
    
    // MARK: - Functions
    /// Generates the `UIViewController` for the button
    /// - Parameter context: The context to generate the button in.
    /// - Returns: The `SiriShortcutViewController` for the `SiriButtonView`
    func makeUIViewController(context: Context) -> SiriShortcutViewController {
        let controller = SiriShortcutViewController()
        controller.intent = intent
        controller.voiceShortcut = voiceShortcut
        return controller
    }
    
    /// Updates the `UIViewController` for the button
    /// - Parameters:
    ///   - uiViewController: The view controller to update
    ///   - context: The context to update the button in.
    func updateUIViewController(_ uiViewController: SiriShortcutViewController, context: Context) {
        
    }
}
