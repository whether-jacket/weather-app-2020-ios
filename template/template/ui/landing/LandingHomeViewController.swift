import UIKit

class LandingHomeViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(true)
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
