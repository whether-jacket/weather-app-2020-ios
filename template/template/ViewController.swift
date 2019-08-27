import UIKit
import SnapKit
import OverlayContainer
import GoogleMaps

class ViewController: BaseViewController {

    enum OverlayNotch: Int, CaseIterable {
        case hidden, minimum, maximum

        func getHeight(withHeight availableHeight: CGFloat) -> CGFloat {
            switch self {
            case .hidden: return 0
            case .minimum: return availableHeight * 1 / 4
            case .maximum: return availableHeight * 3 / 4
            }
        }
    }

    var showsOverlay = false
    private let devicesListViewController = DevicesListViewController()
    private let deviceViewController = DeviceViewController()
    private let overlayController = OverlayContainerViewController()
    private var overlayContainerView = UIView()
    private let expandButton = UIButton()
    private let collapseButton = UIButton()
    internal var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar(true)
        view.backgroundColor = UIColor.white
        initializeViews()
        setConstraints()
    }

    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        canReachNotchAt index: Int,
                                        forOverlay overlayViewController: UIViewController) -> Bool {
        switch OverlayNotch.allCases[index] {
        case .maximum:
            return showsOverlay
        case .minimum:
            return showsOverlay
        case .hidden:
            return !showsOverlay
        }
    }

    private func initializeViews() {
        mapView = GMSMapView()
        view.addSubview(mapView!)
//        mapView!.pinToSuperview()
//        mapView.delegate = self

        expandButton.apply {
            $0.titleColorForNormal = UIColor.black
            $0.setTitle("Expand", for: .normal)
            $0.setOnTapListener(target: self, action: #selector(onExpandButtonTapped))
            view.addSubview($0)
        }
        collapseButton.apply {
            $0.titleColorForNormal = UIColor.black
            $0.setTitle("Collapse", for: .normal)
            $0.setOnTapListener(target: self, action: #selector(onCollapseButtonTapped))
            view.addSubview($0)
        }
        view.addSubview(overlayContainerView)
        setupBottomSheet()
    }

    private func setConstraints() {
        mapView!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        expandButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.top).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
        collapseButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(expandButton.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
        overlayContainerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(collapseButton.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    private func setupBottomSheet() {
        overlayController.delegate = self
        setDevicesListBottomSheet()
    }

    private func notchHeight(for notch: OverlayNotch, availableSpace: CGFloat) -> CGFloat {
        return notch.getHeight(withHeight: availableSpace)
    }

    private func setDevicesListBottomSheet() {
        removeChild(overlayController)
        overlayController.viewControllers = [devicesListViewController]
        addChild(overlayController, in: overlayContainerView)
    }

    private func setDeviceBottomSheet() {
        removeChild(overlayController)
        overlayController.viewControllers = [deviceViewController]
        addChild(overlayController, in: overlayContainerView)
    }

    @objc private func onExpandButtonTapped() {
        setDevicesListBottomSheet()
        log.verbose("expand button tapped")
        showsOverlay.toggle()
        let targetNotch: OverlayNotch = showsOverlay ? .minimum : .hidden
        overlayController.moveOverlay(toNotchAt: targetNotch.rawValue, animated: true)
    }

    @objc private func onCollapseButtonTapped() {
        setDeviceBottomSheet()
        log.verbose("collapse button tapped")
        showsOverlay.toggle()
        let targetNotch: OverlayNotch = showsOverlay ? .minimum : .hidden
        overlayController.moveOverlay(toNotchAt: targetNotch.rawValue, animated: true)
    }
}


extension ViewController: OverlayContainerViewControllerDelegate {

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
                                        scrollViewDrivingOverlay overlayViewController: UIViewController) -> UIScrollView? {
        return (overlayViewController as? DevicesListViewController)?.tableView
    }

    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        shouldStartDraggingOverlay overlayViewController: UIViewController,
                                        at point: CGPoint,
                                        in coordinateSpace: UICoordinateSpace) -> Bool {
//        guard let header = (overlayViewController as? ContentViewController)?.header else {
        return true
//        }
//        let convertedPoint = coordinateSpace.convert(point, to: header)
//        return header.bounds.contains(convertedPoint)
    }

}

extension BaseViewController {
    func addChild(_ child: UIViewController, in containerView: UIView) {
        guard containerView.isDescendant(of: view) else {
            return
        }
        addChild(child)
        containerView.addSubview(child.view)
        child.view.pinToSuperview()
        child.didMove(toParent: self)
    }

    func removeChild(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

extension UIView {
    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
}

extension BaseViewController {

    internal func setNavigationBarTranslucent(_ isTranslucent: Bool) {
        navigationController?.navigationBar.isTranslucent = isTranslucent
    }

    internal func showNavigationBar(_ isShowing: Bool) {
        navigationController?.setNavigationBarHidden(!isShowing, animated: true)
    }
}
