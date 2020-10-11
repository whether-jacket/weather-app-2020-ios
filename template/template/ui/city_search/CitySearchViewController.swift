import DSGradientProgressView
import Foundation
import SnapKit
import UIKit

class CitySearchViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private static let MIN_CHAR_SEARCH = 3
    private let searchBar = UISearchBar()
    private let progressBar = DSGradientProgressView()
    private let citiesTableView = UITableView()
    private var cities: [CityTableItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isNotEmpty()) { return }
        clearResults()
     }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchText = (searchBar.text ?? "").trimmed
        if (searchText.count < CitySearchViewController.MIN_CHAR_SEARCH) { return }
        searchForCities(searchText)
    }

    private func initializeViews() {
        searchBar.apply {
            $0.delegate = self
            $0.returnKeyType = .search
            $0.resignFirstResponder()
            $0.placeholder = Strings.SearchForCity
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
                CitySearchTableViewCell.self,
                forCellReuseIdentifier: CitySearchTableViewCell.IDENTIFIER
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
            make.height.equalTo(Dimens.ProgressBarHeight)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        citiesTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCity = self.cities[indexPath.row]
        var cell: CitySearchTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CitySearchTableViewCell.IDENTIFIER, for: indexPath) as? CitySearchTableViewCell
        if cell == nil || cell?.detailTextLabel == nil {
            cell = CitySearchTableViewCell(style: .subtitle, reuseIdentifier: CitySearchTableViewCell.IDENTIFIER)
        }
        cell!.apply {
            $0.applyTheme(ThemeManager.instance.getCurrentTheme())
            $0.update(with: currentCity)
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowClicked = indexPath.row
        log.verbose("You tapped on: \(cities[rowClicked].cityName).")
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
    
    private func searchForCities(_ searchText: String) {
        showProgressBar()
        clearResults()
        subscribe(MetaWeatherRepo().getLocationsForCitySearch(cityName: searchText)
        .subscribeOnIo()
        .observeOnMain()
            .do(onNext: { (locationsResponse) in
                for location in locationsResponse {
                    let city = CityTableItem(
                        id: location.woeid,
                        cityName: location.cityTitle,
                        regionName: location.locationType
                    )
                    self.cities.append(city)
                }
                self.citiesTableView.reloadData()
                self.hideProgressBar()
            }, onError: { (error) in
                log.error(error)
                self.hideProgressBar()
            })
        .subscribe())
    }
    
    private func clearResults() {
        cities = []
        citiesTableView.reloadData()
    }
}
