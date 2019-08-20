import Foundation
import UIKit
import SnapKit

class DeviceViewController: BaseViewController {

    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        button.titleColorForNormal = UIColor.black
        button.setTitle("Devices List", for: .normal)
        view.addSubview(button)
    }

    private func setConstraints() {
        button.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
    }
}