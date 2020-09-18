import Foundation
import UIKit
import SnapKit

class LetterSpacingsViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.LetterSpacings
        initializeViews()
        setConstraints()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LetterSpacingItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let position = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: LetterSpacingCellView.IDENTIFIER) as! LetterSpacingCellView
        cell.apply {
            $0.setLetterSpacingItem(LetterSpacingItems.allCases[position])
            $0.applyTheme(getCurrentTheme())
        }
        return cell
    }
    
    private func initializeViews() {
        tableView.apply {
            $0.delegate = self
            $0.dataSource = self
            $0.removeEmptyCellDividerLines()
            $0.rowHeight = Dimens.LetterSpacingsCellViewHeight.cgFloat
            $0.register(LetterSpacingCellView.self, forCellReuseIdentifier: LetterSpacingCellView.IDENTIFIER)
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-VerticalSpacings.m)
        }
    }
}
