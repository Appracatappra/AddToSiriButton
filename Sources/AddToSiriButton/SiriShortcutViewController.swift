//
//  SiriShortcutViewController.swift
//  Stuff To Get (iOS)
//
//  Created by Kevin Mullins on 6/24/21.
//  From: https://www.reddit.com/r/SwiftUI/comments/fhh1fw/add_to_siri_button_with_swiftui/
//

import UIKit
import Intents
import IntentsUI

/// Creates a Siri Shortcut View Controller that can be used within SwiftUI.
class SiriShortcutViewController: UIViewController {
    // MARK: - Properties
    /// The intent to generate the `INUIAddVoiceShortcutButton` for.
    var intent: INIntent? = nil
    
    /// The Voice Shortcut to generate the `INUIAddVoiceShortcutButton` for.
    var voiceShortcut: INVoiceShortcut? = nil
    
    // MARK: - Initializers
    
    /// Creates a new instance of the object.
    override func viewDidLoad() {
        super.viewDidLoad()
        addSiriButton(to: view)
    }
    
    // MARK: - Functions
    
    /// Adds the Siri Voice Shortcut Button to the given give
    /// - Parameter view: The view to add the button to.
    func addSiriButton(to view: UIView) {
        #if !targetEnvironment(macCatalyst)
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        setupShortcut(to: button)
        #endif
    }
    
    /// Configures the Vioce Shortcut for the button
    /// - Parameter button: The Siri Voice Shortcut Button to configure.
    func setupShortcut(to button: INUIAddVoiceShortcutButton?) {
        if let intent = intent {
            button?.shortcut = INShortcut(intent: intent)
            button?.delegate = self
        } else if let voiceShortcut = voiceShortcut {
            button?.shortcut = voiceShortcut.shortcut
            button?.delegate = self
        }
    }
}

/// Extends the `SiriShortcutViewController` to conform to the `INUIAddVoiceShortcutViewControllerDelegate` protocol.
extension SiriShortcutViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    /// Handles the Voice Shortcut button being dismissed.
    /// - Parameters:
    ///   - controller: The view controller
    ///   - voiceShortcut: The shortcut being handled.
    ///   - error: An error, if one exists else `nil`.
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Handles the Vioce Shortcut button being dismissed by the user.
    /// - Parameter controller: The view controller.
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

/// Extends the `SiriShortcutViewController` to conform to the `INUIAddVoiceShortcutButtonDelegate` protocol.
extension SiriShortcutViewController: INUIAddVoiceShortcutButtonDelegate {
    
    /// Presents the add shortcut button being presented to the user.
    /// - Parameters:
    ///   - addVoiceShortcutViewController: The view controller.
    ///   - addVoiceShortcutButton: The Voice Shortcut Button to present.
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    /// Handles the edit shortcut button being presented to the user.
    /// - Parameters:
    ///   - editVoiceShortcutViewController: The view controller.
    ///   - addVoiceShortcutButton: The Voice Shortcut Button.
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

/// Extends the `SiriShortcutViewController` to conform to the `INUIEditVoiceShortcutViewControllerDelegate` protocol.
extension SiriShortcutViewController: INUIEditVoiceShortcutViewControllerDelegate {
    
    /// Handles the shortcut being updated.
    /// - Parameters:
    ///   - controller: The view controller.
    ///   - voiceShortcut: The voice shortcut being modified.
    ///   - error: An error, if one exists else `nil`.
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Handles the shortcut being deleted
    /// - Parameters:
    ///   - controller: The view controller.
    ///   - deletedVoiceShortcutIdentifier: The id of the voice shortcut being deleted.
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Handles the user canceling the shortcut edit.
    /// - Parameter controller: The view controller.
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
