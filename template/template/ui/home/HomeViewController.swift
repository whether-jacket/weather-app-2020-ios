import UIKit
import SnapKit

class HomeViewController: BaseViewController {

    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
//        fetchWeatherForLocation()
//        fetchCities()
    }

    private func initializeViews() {
        button.titleColorForNormal = UIColor.black
        button.setTitle("Hello Home", for: .normal)
        view.addSubview(button)
    }

    private func setConstraints() {
        button.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.top).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
    }
    
    private func fetchCities() {
        subscribe(MetaWeatherRepo().getLocationsForCitySearch(cityName: "san")
        .subscribeOnIo()
        .observeOnMain()
            .do(onNext: { (locationsResponse) in
                log.debug("Response cities: ")
                for location in locationsResponse {
                    log.debug("City: " + location.cityTitle)
                }
            }, onError: { (error) in
                log.debug(error)
            })
        .subscribe())
    }
    
    private func fetchWeatherForLocation() {
        subscribe(MetaWeatherRepo().getWeatherForWhereOnEarthId(whereOnEarthId: 2487956)
        .subscribeOnIo()
        .observeOnMain()
            .do(onNext: { (weatherForLocationResponse) in
                log.debug("Response: " + weatherForLocationResponse.lattLong)
            }, onError: { (error) in
                log.debug(error)
            })
        .subscribe())
    }
}
