import DSGradientProgressView
import Foundation
import OverlayContainer
import SnapKit
import UIKit

class CitySearchViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let searchBar = UISearchBar()
    private let progressBar = DSGradientProgressView()
    public let citiesTableView = UITableView()
    private var cities = [
        CityTableItem(id: 1, cityName: "San Francisco", regionName: "CA"),
        CityTableItem(id: 1, cityName: "San Diego", regionName: "CA"),
        CityTableItem(id: 1, cityName: "Tempe", regionName: "AZ")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        searchBar.apply {
            view.addSubview($0)
        }
        progressBar.apply {
            view.addSubview($0)
            self.hideProgressBar()
        }
        citiesTableView.apply {
            $0.delegate = self
            $0.dataSource = self
            $0.register(
                CityTableViewCell.self,
                forCellReuseIdentifier: CityTableViewCell.IDENTIFIER
            )
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.rowHeight = Dimens.WidgetCellHeight.cgFloat
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        searchBar.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        progressBar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        citiesTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    private func showProgressBar() {
        progressBar.apply {
            $0.isHidden = false
            $0.wait()
        }
    }

    private func hideProgressBar() {
        progressBar.apply {
            $0.isHidden = true
            $0.signal()
        }
    }
}
