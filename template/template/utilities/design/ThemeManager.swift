import Foundation

class ThemeManager {

    public static let instance = ThemeManager()

    private var currentTheme: Theme? = nil

    func getCurrentTheme() -> Theme {
        if let cachedTheme = currentTheme {
            return cachedTheme
        }
        currentTheme = getThemeForNightMode(false)
        return currentTheme!
    }

    func setTheme(_ theme: Theme) {
        currentTheme = theme
    }

    func setTheme(_ isInNightMode: Bool) {
        setTheme(getThemeForNightMode(isInNightMode))
    }

    private func getThemeForNightMode(_ isInNightMode: Bool) -> Theme {
        return isInNightMode ? Theme.Illini : Theme.Tokyo
    }
}
