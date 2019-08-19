import Foundation

struct App {
    
    public static func getAppName() -> String  {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    public static func getVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
