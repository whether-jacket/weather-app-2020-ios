import RxSwift
import UIKit

class BaseViewController: UIViewController, NavigationControllerBackButtonDelegate  {

    private struct LogGlobals {
        var prefix = ""
        var instanceCounts = [String:Int]()
        var lastLogTime = Date()
        var indentationInterval: TimeInterval = 1
        var indentationString = "__"
    }
    private static var logGlobals = LogGlobals()
    internal var vclLoggingName: String {
        String(describing: type(of: self))
    }
    private var instanceCount: Int!
    private var compositeDisposable = CompositeDisposable()

    private static func logPrefix(for loggingName: String) -> String {
        if logGlobals.lastLogTime.timeIntervalSinceNow < -logGlobals.indentationInterval {
            logGlobals.prefix += logGlobals.indentationString
            print("")
        }
        logGlobals.lastLogTime = Date()
        return logGlobals.prefix + loggingName
    }

    private static func bumpInstanceCount(for loggingName: String) -> Int {
        logGlobals.instanceCounts[loggingName] = (logGlobals.instanceCounts[loggingName] ?? 0) + 1
        return logGlobals.instanceCounts[loggingName]!
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logVCL("init(coder:) - created via InterfaceBuilder ")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVCL("init(nibName:bundle:) - create in code")
    }

    deinit {
        logVCL("left the heap")
    }

    override func awakeFromNib() {
        logVCL("awakeFromNib()")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
        applyTheme(getCurrentTheme())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viewWillAppear(animated = \(animated))")
        applyTheme(getCurrentTheme())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVCL("viewDidDisappear(animated = \(animated))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logVCL("didReceiveMemoryWarning()")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVCL("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        logVCL("viewWillTransition(to: \(size), with: coordinator)")
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.logVCL("begin animate(alongsideTransition:completion:)")
        }, completion: { context -> Void in
            self.logVCL("end animate(alongsideTransition:completion:)")
        })
    }

    internal func shouldPopOnBackButtonPress(_ completion: @escaping (Bool) -> ()) {
        completion(true)
    }

    @discardableResult
    internal func subscribe(_ disposable: Disposable) -> CompositeDisposable.DisposeKey? {
        compositeDisposable.insert(disposable)
    }

    internal func removeDisposable(_ disposeKey: CompositeDisposable.DisposeKey) {
        compositeDisposable.remove(for: disposeKey)
    }

    internal func clearSubscriptions() {
        compositeDisposable.dispose()
        compositeDisposable = CompositeDisposable()
    }

    internal func getCurrentTheme() -> Theme {
        ThemeManager.instance.getCurrentTheme()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return getCurrentTheme().isLight ? .darkContent : .lightContent
        } else {
            return getCurrentTheme().isLight ? .default : .lightContent
        }
    }

    private func isSystemInNightMode() -> Bool {
        traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark
    }

    private func logVCL(_ msg: String) {
        if instanceCount == nil {
            instanceCount =  BaseViewController.bumpInstanceCount(for: vclLoggingName)
        }
        let msg = "\(BaseViewController.logPrefix(for: vclLoggingName))(\(instanceCount!)) \(msg)"
        logLifeCycle.verbose(msg)
    }
}
