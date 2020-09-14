import UIKit

class LandingHomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }

    private func initializeViews() {
        let homeViewController = HomeViewController().apply {
            $0.tabBarItem = BottomNavTabs.HOME.getTabBarItem()
        }

        let citiesViewController = CitiesViewController().apply {
            $0.tabBarItem = BottomNavTabs.CITIES.getTabBarItem()
        }
        
        let settingsViewController = SettingsViewController().apply {
            $0.tabBarItem = BottomNavTabs.SETTINGS.getTabBarItem()
        }
        
        viewControllers = [homeViewController, citiesViewController, settingsViewController]
    }
}

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
