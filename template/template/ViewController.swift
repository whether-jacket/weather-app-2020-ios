import UIKit
import SnapKit
import OverlayContainer

class ViewController: BaseViewController {

    enum OverlayNotch: Int, CaseIterable {
        case hidden, minimum, maximum
    }

    var showsOverlay = false
    let searchController = ContentViewController()
    let overlayController = OverlayContainerViewController()
    private var overlayContainerView = UIView()
    private let expandButton = UIButton()
    private let collapseButton = UIButton()

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
        expandButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.top).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
        overlayContainerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(expandButton.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-VerticalSpacings.m)
        }
    }

    private func setupBottomSheet() {
        overlayController.delegate = self
        overlayController.viewControllers = [searchController]
        addChild(overlayController, in: overlayContainerView)
    }

    private func notchHeight(for notch: OverlayNotch, availableSpace: CGFloat) -> CGFloat {
        switch notch {
            case .maximum:
                return availableSpace * 3 / 4
            case .minimum:
                return availableSpace * 1 / 4
            case .hidden:
                return 0
        }
    }

    @objc private func onExpandButtonTapped() {
        log.verbose("expand button tapped")
        showsOverlay.toggle()
        let targetNotch: OverlayNotch = showsOverlay ? .minimum : .hidden
        overlayController.moveOverlay(toNotchAt: targetNotch.rawValue, animated: true)
    }

    @objc private func onCollapseButtonTapped() {
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
        return (overlayViewController as? ContentViewController)?.tableView
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
        guard containerView.isDescendant(of: view) else { return }
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
        guard let superview = superview else { return }
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