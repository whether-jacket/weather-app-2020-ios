import Foundation
import UIKit

// https://developer.apple.com/documentation/uikit/uiprogressview
class ProgressViewController: BaseViewController {

    private let progressView = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar(true)
        title = Strings.Progress
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        view.backgroundColor = .white
        progressView.apply {
            $0.setProgress(0.50, animated: false)
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        progressView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
    }
}
