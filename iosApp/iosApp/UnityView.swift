//
//  UnityView.swift
//  iosApp
//
//  Created by Tony Ayman on 17.04.25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import UnityFramework

struct UnityView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        UnityLauncher.shared.launchUnity()
        // Safely unwrap the Unity view
        guard let unityRoot = UnityLauncher.shared.ufw?
                                  .appController()?
                                  .rootView else {
            // Fallback if it’s still nil
            return UIView()
        }

        // UIKit API — set its frame directly, not via SwiftUI modifiers
        unityRoot.frame = UIScreen.main.bounds
        unityRoot.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        unityRoot.isUserInteractionEnabled = false // Disable interaction for Unity view
        unityRoot.backgroundColor = UIColor.clear // Ensure Unity view has a transparent background

        // Ensure the Unity view does not block SwiftUI rendering
        unityRoot.layer.zPosition = -1

        return unityRoot
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}


