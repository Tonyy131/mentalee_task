import UIKit
import SwiftUI
import UnityFramework

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Load UnityFramework from the app's Frameworks folder
        guard let frameworkURL = Bundle.main.executableURL?
                .deletingLastPathComponent()
                .appendingPathComponent("Frameworks/UnityFramework.framework"),
              let unityBundle = Bundle(url: frameworkURL)
        else {
            fatalError("🔴 UnityFramework.framework not found in app bundle")
        }
        unityBundle.load()

        // Initialize UnityFramework instance
        guard let ufwClass = unityBundle.principalClass as? UnityFramework.Type,
              let ufw = ufwClass.getInstance()
        else {
            fatalError("🔴 Could not instantiate UnityFramework")
        }
        ufw.setDataBundleId("com.unity3d.framework")
        ufw.runEmbedded(
            withArgc: CommandLine.argc,
            argv: CommandLine.unsafeArgv,
            appLaunchOpts: launchOptions
        )

        // Delay the insertion to ensure the SwiftUI window is loaded
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
                fatalError("🔴 Unable to find SwiftUI key window")
            }

            // Insert Unity's view below the SwiftUI content
            if let unityRoot = ufw.appController()?.rootView {
                unityRoot.frame = window.bounds
                unityRoot.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                unityRoot.isUserInteractionEnabled = false  // Let SwiftUI handle taps

                // Insert Unity's root view behind SwiftUI content
                window.rootViewController?.view.insertSubview(unityRoot, at: 0)
            }
        }

        return true
    }
}
