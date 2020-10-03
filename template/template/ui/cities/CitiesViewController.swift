import UIKit
import SnapKit

class CitiesViewController : UITableViewController {
    
    var cities = [
        CityTableItem(id: 1, cityName: "San Francisco", regionName: "CA"),
        CityTableItem(id: 1, cityName: "San Diego", regionName: "CA"),
        CityTableItem(id: 1, cityName: "Tempe", regionName: "AZ")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.apply {
            $0.isEditing = true
            $0.register(
                CityTableViewCell.self,
                forCellReuseIdentifier: CityTableViewCell.IDENTIFIER
            )
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.rowHeight = Dimens.WidgetCellHeight.cgFloat
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCity = self.cities[indexPath.row]
        var cell: CityTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.IDENTIFIER, for: indexPath) as? CityTableViewCell
        if cell == nil || cell?.detailTextLabel == nil {
            cell = CityTableViewCell(style: .subtitle, reuseIdentifier: CityTableViewCell.IDENTIFIER)
        }
        let imageView = cell!.subviews.first(where: { $0.description.contains("Reorder") })?.subviews.first(where: { $0 is UIImageView }) as? UIImageView
        imageView?.tintColor = ThemeManager.instance.getCurrentTheme().dividerColor
        cell!.apply {
            $0.applyTheme(ThemeManager.instance.getCurrentTheme())
            
            $0.update(with: currentCity)
        }
        return cell!
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.cities[sourceIndexPath.row]
        cities.remove(at: sourceIndexPath.row)
        cities.insert(movedObject, at: destinationIndexPath.row)
        debugPrint("\(sourceIndexPath.row) => \(destinationIndexPath.row)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
