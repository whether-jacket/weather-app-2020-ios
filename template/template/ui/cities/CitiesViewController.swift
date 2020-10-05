import OverlayContainer
import SnapKit
import UIKit

class CitiesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var cities = [
        CityTableItem(id: 1, cityName: "San Francisco", regionName: "CA"),
        CityTableItem(id: 1, cityName: "San Diego", regionName: "CA"),
        CityTableItem(id: 1, cityName: "Tempe", regionName: "AZ")
    ]
    private let citiesTableView = UITableView()
    private let addCityButton = UIButton(type: .contactAdd)
    private var overlayContainerView = PassThroughView()
    
    private let citySearchViewController = CitySearchViewController()
    private let overlayController = OverlayContainerViewController()
    var showsOverlay = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        citiesTableView.apply {
            $0.delegate = self
            $0.dataSource = self
            $0.isEditing = true
            $0.register(
                CityTableViewCell.self,
                forCellReuseIdentifier: CityTableViewCell.IDENTIFIER
            )
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.rowHeight = Dimens.WidgetCellHeight.cgFloat
            view.insertSubview($0, at: 0)
        }
        addCityButton.apply {
            $0.setOnTapListener(target: self, action: #selector(onCityButtonTapped))
            view.insertSubview($0, at: 0)
        }
        overlayContainerView.apply {
            view.insertSubview($0, at: 1)
        }
        overlayController.delegate = self
        setupBottomSheet()
    }

    private func setConstraints() {
        citiesTableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(addCityButton.snp.top)
        }
        addCityButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-VerticalSpacings.m)
        }
        overlayContainerView.snp.updateConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBottomSheet() {
        removeChild(overlayController)
        overlayController.viewControllers = [citySearchViewController]
        addChild(overlayController, in: overlayContainerView)
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

    @objc private func onCityButtonTapped() {
        log.verbose("we tapped on add city button")
//        setupBottomSheet()
        showsOverlay.toggle()
        let targetNotch: OverlayNotch = showsOverlay ? .maximum : .hidden
        overlayController.moveOverlay(toNotchAt: targetNotch.rawValue, animated: true)
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
            self.citiesTableView.deleteRows(at: [indexPath], with: .fade)
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

// MARK: OverlayContainer
extension CitiesViewController: OverlayContainerViewControllerDelegate {

    func notchHeight(for notch: OverlayNotch, availableSpace: CGFloat) -> CGFloat {
        return notch.getHeight(withHeight: availableSpace)
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return OverlayNotch.allCases.count
    }

    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        heightForNotchAt index: Int,
                                        availableSpace: CGFloat) -> CGFloat {
        let notch = OverlayNotch.allCases[index]
        return notchHeight(for: notch, availableSpace: availableSpace)
    }

    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        scrollViewDrivingOverlay overlayViewController:
                                            UIViewController) -> UIScrollView? {
        return (overlayViewController as? CitySearchViewController)?.citiesTableView
    }

    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        shouldStartDraggingOverlay overlayViewController: UIViewController,
                                        at point: CGPoint,
                                        in coordinateSpace: UICoordinateSpace) -> Bool {
        return true
    }

}
