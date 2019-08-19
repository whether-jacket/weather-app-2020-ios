import UIKit
import SnapKit

class ViewController: BaseViewController {

    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        button.titleColorForNormal = UIColor.black
        button.setTitle("Hello world", for: .normal)
        view.addSubview(button)
    }

    private func setConstraints() {
        button.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.top).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
    }
}
