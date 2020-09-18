import Foundation
import UIKit

// https://developer.apple.com/documentation/uikit/uiswitch
class SwitchViewController: BaseViewController {

    private let switchLabel = UILabel()
    private let sampleSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar(true)
        title = Strings.Switch
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        switchLabel.apply {
            $0.text = Strings.Switch
            $0.setTextAppearance(.Subheadline)
            view.addSubview($0)
        }
        sampleSwitch.apply {
            $0.addTarget(self, action: #selector(onSampleSwitchChanged), for: UIControl.Event.valueChanged)
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        switchLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        sampleSwitch.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(switchLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
    }

    @objc private func onSampleSwitchChanged(uiSwitch: UISwitch) {
        let isSwitchEnabled: Bool = uiSwitch.isOn
        UIAlertController(title: "", message: isSwitchEnabled.string, preferredStyle: UIAlertController.Style.alert).apply {
            $0.addAction(UIAlertAction(
                    title: Strings.OK,
                    style: UIAlertAction.Style.default,
                    handler: { (action: UIAlertAction) -> Void in }))
            self.present($0, animated: true, completion: nil)
        }
    }
}
