import Foundation
import UIKit

// https://developer.apple.com/documentation/uikit/uilabel
class LabelViewController: BaseViewController {

    private let sampleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar(true)
        title = Strings.Label
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        sampleLabel.apply {
            $0.text = Strings.Label
            $0.setTextAppearance(.Subheadline)
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        sampleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
    }
}
