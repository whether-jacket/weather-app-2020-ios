import UIKit
import SnapKit

class SettingsViewController: BaseViewController {

    private let temperatureInMetricLabel = UILabel()
    private let temperatureInMetricSwitch = UISwitch()
    private let speedInMetricLabel = UILabel()
    private let speedInMetricSwitch = UISwitch()
    private let darkModeLabel = UILabel()
    private let darkModeSwitch = UISwitch()
    private let debugDividerLine = UIView()
    private let themingButton = BorderedButton()
    private let widgetsButton = BorderedButton()
    private let samplePagesButton = BorderedButton()
    private let designTokensButton = BorderedButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        temperatureInMetricLabel.apply {
            $0.text = Strings.TemperatureInMetric
            view.addSubview($0)
        }
        temperatureInMetricSwitch.apply {
            $0.addTarget(self, action: #selector(onTemperatureInMetricSwitched), for: UIControl.Event.valueChanged)
            view.addSubview($0)
        }
        speedInMetricLabel.apply {
            $0.text = Strings.SpeedInMetric
            view.addSubview($0)
        }
        speedInMetricSwitch.apply {
            $0.addTarget(self, action: #selector(onSpeedInMetricSwitched), for: UIControl.Event.valueChanged)
            view.addSubview($0)
        }
        darkModeLabel.apply {
            $0.text = Strings.DarkMode
            view.addSubview($0)
        }
        darkModeSwitch.apply {
            $0.addTarget(self, action: #selector(onDarkModeSwitched), for: UIControl.Event.valueChanged)
            view.addSubview($0)
        }
        debugDividerLine.apply {
            $0.backgroundColor = ThemeManager.instance.getCurrentTheme().dividerColor
            view.addSubview($0)
        }
        themingButton.apply {
            $0.setTitle(Strings.Theming, for: .normal)
            $0.setOnTapListener(target: self, action: #selector(onThemingButtonPressed))
            view.addSubview($0)
        }
        widgetsButton.apply {
            $0.setTitle(Strings.Widgets, for: .normal)
            $0.setOnTapListener(target: self, action: #selector(onWidgetsButtonPressed))
            view.addSubview($0)
        }
        samplePagesButton.apply {
            $0.setTitle(Strings.SamplePages, for: .normal)
            $0.setOnTapListener(target: self, action: #selector(onSamplePagesButtonPressed))
            view.addSubview($0)
        }
        designTokensButton.apply {
            $0.setTitle(Strings.DesignTokens, for: .normal)
            $0.setOnTapListener(target: self, action: #selector(onDesignTokensButtonPressed))
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        temperatureInMetricLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.top).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        temperatureInMetricSwitch.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(temperatureInMetricLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
        speedInMetricLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(temperatureInMetricLabel.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        speedInMetricSwitch.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(speedInMetricLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
        darkModeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(speedInMetricLabel.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        darkModeSwitch.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(darkModeLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
        debugDividerLine.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(darkModeLabel.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
            make.height.equalTo(Dimens.HorizontalDividerLineHeight)
        }
        themingButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(debugDividerLine.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        widgetsButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(themingButton.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        samplePagesButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(widgetsButton.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        designTokensButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(samplePagesButton.snp.bottom).offset(VerticalSpacings.l)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
    }
    
    @objc func onTemperatureInMetricSwitched(tempInMetricSwitch: UISwitch) {
        let isMetric = tempInMetricSwitch.isOn
        log.debug("tempInMetricSwitch " + isMetric.string)
    }

    @objc func onSpeedInMetricSwitched(speedInMetricSwitch: UISwitch) {
        let isMetric = speedInMetricSwitch.isOn
        log.debug("speedInMetricSwitch " + isMetric.string)
    }
    
    @objc func onDarkModeSwitched(darkModeSwitch: UISwitch) {
        let isDarkMode = darkModeSwitch.isOn
        log.debug("isDarkMode " + isDarkMode.string)
        ThemeManager.instance.setTheme(isDarkMode)
        // TODO: Restart App
    }
    
    @objc func onThemingButtonPressed() {
        log.debug("theme pressed")
    }
    
    @objc func onWidgetsButtonPressed() {
        log.debug("widgets pressed")
        pushViewController(WidgetsViewController())
    }
    
    @objc func onSamplePagesButtonPressed() {
        log.debug("sample pages pressed")
    }
    
    @objc func onDesignTokensButtonPressed() {
        log.debug("design tokens pressed")
        pushViewController(DesignTokenLandingPageViewController())
    }
}
