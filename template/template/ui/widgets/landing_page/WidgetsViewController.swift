import Foundation
import SnapKit
import UIKit

class WidgetsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    private let cellReuseIdentifier = "cell"
    private var widgetsList: [Widgets] = Widgets.allCases
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar(true)
        title = Strings.Widgets
        initializeViews()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func indexPath(for cell: UITableViewCell) -> IndexPath? {
        tableView.indexPath(for: cell)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? WidgetTableViewCell else {
            return
        }
        cell.setOnTapListener(target: self, action: #selector(onWidgetTapped), argument: cell)
    }

    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        widgetsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentWidget = self.widgetsList[indexPath.row]
        var cell: WidgetTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? WidgetTableViewCell
        if cell == nil || cell?.detailTextLabel == nil {
            cell = WidgetTableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        }
        cell!.apply {
            $0.update(with: currentWidget)
        }
        return cell!
    }


    private func initializeViews() {
        view.backgroundColor = .white
        tableView.apply {
            $0.register(WidgetTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.rowHeight = Dimens.WidgetCellHeight.cgFloat
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc private func onWidgetTapped(_ sender: Any) {
        guard let recognizer = sender as? MyTapGestureRecognizer else {
            return
        }
        guard let cell = recognizer.argument as? WidgetTableViewCell else {
            return
        }
        guard let widget = cell.widget else {
            return
        }
        var viewController: UIViewController
        switch widget {
        case .SWITCH:
            viewController = SwitchViewController()
        case .LABEL:
            viewController = LabelViewController()
        case .PROGRESS:
            viewController = ProgressViewController()
        }
        pushViewController(viewController)
    }
}
