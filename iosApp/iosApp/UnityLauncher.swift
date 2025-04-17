import UIKit
import UnityFramework

class UnityLauncher: NSObject {
    var ufw: UnityFramework?

    static let shared = UnityLauncher()

    func launchUnity() {
        if ufw == nil {
            // Path to UnityFramework
            let bundlePath = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
            
            // Check if the bundle exists and load it
            guard let bundle = Bundle(path: bundlePath) else {
                print("Failed to find UnityFramework at path: \(bundlePath)")
                return
            }
            
            // Load the framework
            if bundle.load() {
                // If framework loaded successfully, get the UnityFramework instance
                if let unityFrameworkClass = bundle.principalClass as? UnityFramework.Type {
                    ufw = unityFrameworkClass.getInstance()
                    ufw?.setDataBundleId("com.unity3d.framework")
                    ufw?.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: nil)
                } else {
                    print("Failed to get UnityFramework class from bundle")
                }
            } else {
                print("Failed to load UnityFramework")
            }
        }
    }

    func showUnity() {
        ufw?.appController()?.window.makeKeyAndVisible()
    }
}
