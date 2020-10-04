import UIKit
import SnapKit

class CitiesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var cities = [
        CityTableItem(id: 1, cityName: "San Francisco", regionName: "CA"),
        CityTableItem(id: 1, cityName: "San Diego", regionName: "CA"),
        CityTableItem(id: 1, cityName: "Tempe", regionName: "AZ")
    ]
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        tableView.apply {
            $0.isEditing = true
            $0.allowsMultipleSelection = false
            $0.allowsSelection = false
            $0.allowsMultipleSelectionDuringEditing = false
            $0.register(
                CityTableViewCell.self,
                forCellReuseIdentifier: CityTableViewCell.IDENTIFIER
            )
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.rowHeight = Dimens.WidgetCellHeight.cgFloat
            $0.delegate = self
            $0.dataSource = self
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCity = self.cities[indexPath.row]
        var cell: CityTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.IDENTIFIER, for: indexPath) as? CityTableViewCell
        if cell == nil || cell?.detailTextLabel == nil {
            cell = CityTableViewCell(style: .subtitle, reuseIdentifier: CityTableViewCell.IDENTIFIER)
        }
        cell!.apply {
            $0.applyTheme(ThemeManager.instance.getCurrentTheme())
            $0.update(with: currentCity)
        }
        return cell!
    }
}

// MARK: Swiping
extension CitiesViewController {
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }
    
     private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: Strings.Delete) { (action, swipeButtonView, completion) in
            log.verbose("we are swipe to deleting: \(indexPath.row)")
            self.cities.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
         }
     }
}

// MARK: Reordering
extension CitiesViewController {
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        log.verbose("we are moving \(sourceIndexPath.row) => \(destinationIndexPath.row)")
        let movedObject = self.cities[sourceIndexPath.row]
        self.cities.remove(at: sourceIndexPath.row)
        self.cities.insert(movedObject, at: destinationIndexPath.row)
    }
}
