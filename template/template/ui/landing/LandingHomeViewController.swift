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
