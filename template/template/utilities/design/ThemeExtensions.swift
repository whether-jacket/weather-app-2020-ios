import Foundation
import UIKit
import MaterialComponents

extension Theme {

    // Global
    func applyApplyGlobally() {
        applyToUIButton()
        applyToUISwitch()
        applyToUILabel()
        applyToUITextField()
        applyToMDCTextField()
    }

    func applyToMDCTextField() {
        MDCTextField.appearance().apply {
            $0.backgroundColor = backgroundColor
        }
    }

    func applyToUISwitch() {
        UISwitch.appearance().apply {
            $0.onTintColor = accentColor
        }
    }

    func applyToUIButton() {
        UIButton.appearance().apply {
            $0.setTitleColor(normalColor, for: UIControl.State.normal)
            $0.tintColor = normalColor
        }
    }

    func applyToUILabel() {
        UILabel.appearance().apply {
            $0.textColor = normalColor
        }
    }

    func applyToUITextField() {
        UITextField.appearance().apply {
            $0.textColor = normalColor
        }
    }

    // Individual View
    func applyToUiView(_ view: UIView) {
        switch view {
        case is UIButton:
            (view as! UIButton).applyTheme(self)
        case is UILabel:
            (view as! UILabel).applyTheme(self)
        case is UISegmentedControl:
            (view as! UISegmentedControl).applyTheme(self)
        case is UITableView:
            (view as! UITableView).applyTheme(self)
        case is UITableViewCell:
            (view as! UITableViewCell).applyTheme(self)
        case is UITextField:
            (view as! UITextField).applyTheme(self)
        case is UIToolbar:
            (view as! UIToolbar).applyTheme(self)
        default: break
        }
        view.subviews.map { (subView: UIView) -> Void in
            applyToUiView(subView)
        }
    }
}

extension MDCTextInputControllerBase {
    func applyTheme(_ theme: Theme) {
        self.apply {
            $0.floatingPlaceholderNormalColor = theme.normalColor
            $0.floatingPlaceholderActiveColor = theme.accentColor
            $0.activeColor = theme.accentColor
            $0.inlinePlaceholderColor = theme.normalColor
            $0.errorColor = theme.inputErrorColor
        }
    }
}

extension UIBarButtonItem {
    func applyTheme(_ theme: Theme) {
        self.tintColor = theme.normalColor
    }
}

extension UIButton {
    func applyTheme(_ theme: Theme) {
        self.tintColor = theme.normalColor
        self.setTitleColor(theme.normalColor, for: UIControl.State.normal)
    }
}

extension UILabel {
    func applyTheme(_ theme: Theme) {
        textColor = theme.normalColor
    }
}

extension UISegmentedControl {
    func applyTheme(_ theme: Theme) {
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = theme.accentColor
        }
    }
}

extension UITableView {
    func applyTheme(_ theme: Theme) {
        self.backgroundColor = theme.backgroundColor
        self.subviews.map { (tableSubView: UIView) -> Void in
            theme.applyToUiView(tableSubView)
        }
    }
}

extension UITableViewCell {
    func applyTheme(_ theme: Theme) {
        self.backgroundColor = theme.backgroundColor
        self.subviews.map { (tableSubView: UIView) -> Void in
            theme.applyToUiView(tableSubView)
        }
    }
}

extension UITextField {
    func applyTheme(_ theme: Theme) {
        self.textColor = theme.normalColor
    }
}

extension UIToolbar {
    func applyTheme(_ theme: Theme) {
        self.barTintColor = theme.primaryDarkColor
        self.items?.forEach { barButtonItem in
            barButtonItem.applyTheme(theme)
        }
    }
}

extension UINavigationBar {
    func applyTheme(_ theme: Theme) {
        self.apply {
            $0.backgroundColor = theme.primaryColor
            $0.tintColor = theme.normalColor
            $0.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.normalColor]
        }
        // TODO: Figure out what this does:
//        let sharedApplication = UIApplication.shared
//        sharedApplication.delegate?.window??.backgroundColor = primaryColor
    }
}

extension UIViewController {
    func applyTheme(_ theme: Theme) {
        theme.applyApplyGlobally()
        self.view.apply {
            $0.backgroundColor = theme.backgroundColor
        }
        if let navBar = self.navigationController?.navigationBar {
            navBar.applyTheme(theme)
        }
        self.view.subviews.map { (view: UIView) -> Void in
            theme.applyToUiView(view)
        }
    }
}
