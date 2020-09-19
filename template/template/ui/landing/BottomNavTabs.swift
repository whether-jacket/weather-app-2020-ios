import Foundation

enum BottomNavTabs: Int, CaseIterable {
    case HOME
    case CITIES
    case SETTINGS

    func getTabBarItem() -> UITabBarItem {
        switch self {
        case .HOME: return UITabBarItem(title: Strings.Home, image: UIImage(), tag: 0)
        case .CITIES: return UITabBarItem(title: Strings.Cities, image: UIImage(), tag: 1)
        case .SETTINGS: return UITabBarItem(title: Strings.Settings, image: UIImage(), tag: 2)
        }
    }

}
