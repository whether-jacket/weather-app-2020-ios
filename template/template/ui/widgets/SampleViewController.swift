//import Foundation
//import UIKit
//
//class : UIViewController {
//
//    private let switchLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        showNavigationBar(true)
//        title = Strings.Switch
//        initializeViews()
//        setConstraints()
//    }
//
//    private func initializeViews() {
//        view.backgroundColor = .white
//        switchLabel.apply {
//            $0.text = Strings.Switch
//            $0.setTextAppearance(.Subhead)
//            view.addSubview($0)
//        }
//    }
//
//    private func setConstraints() {
//        switchLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(VerticalSpacings.m)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
//        }
//    }
//}
