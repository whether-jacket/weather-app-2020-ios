import DSGradientProgressView
import UIKit
import SnapKit
import SwiftDate

class HomeViewController: BaseViewController {

    private let DATE_FORMAT = YearMonthDay.MMM_D_YYYY_SPACE.rawValue
    private let progressBar = DSGradientProgressView()
    private let cityNameLabel = UILabel()
    private let regionNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let temperatureImage = UIImageView()
    private let pressureTitleLabel = UILabel()
    private let pressureLabel = UILabel()
    private let humidityTitleLabel = UILabel()
    private let humidityLabel = UILabel()
    private let windSpeedTitleLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let dateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setConstraints()
        showMockData()
//        fetchWeatherForLocation()
//        fetchCities()
    }

    private func initializeViews() {
        progressBar.apply {
            view.addSubview($0)
            self.hideProgressBar()
        }
        cityNameLabel.apply {
            $0.setTextAppearance(.Headline)
            $0.isHidden = true
            view.addSubview($0)
        }
        regionNameLabel.apply {
            $0.setTextAppearance(.Subheadline)
            $0.isHidden = true
            view.addSubview($0)
        }
        temperatureLabel.apply {
            $0.setTextAppearance(.Headline)
            $0.isHidden = true
            view.addSubview($0)
        }
        temperatureImage.apply {
            $0.isHidden = true
            view.addSubview($0)
        }
        pressureTitleLabel.apply {
            $0.setTextAppearance(.Body)
            $0.text = Strings.Pressure
            $0.setUnderlined()
            $0.isHidden = true
            view.addSubview($0)
        }
        pressureLabel.apply {
            $0.setTextAppearance(.Caption1)
            $0.isHidden = true
            view.addSubview($0)
        }
        humidityTitleLabel.apply {
            $0.setTextAppearance(.Body)
            $0.text = Strings.Humidity
            $0.setUnderlined()
            $0.isHidden = true
            view.addSubview($0)
        }
        humidityLabel.apply {
            $0.setTextAppearance(.Caption1)
            $0.isHidden = true
            view.addSubview($0)
        }
        windSpeedTitleLabel.apply {
            $0.setTextAppearance(.Body)
            $0.text = Strings.WindSpeed
            $0.setUnderlined()
            $0.isHidden = true
            view.addSubview($0)
        }
        windSpeedLabel.apply {
            $0.setTextAppearance(.Caption1)
            $0.isHidden = true
            view.addSubview($0)
        }
        dateLabel.apply {
            $0.setTextAppearance(.Subheadline)
            $0.isHidden = true
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        progressBar.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(Dimens.ProgressBarHeight)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        cityNameLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(VerticalSpacings.m)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        regionNameLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(VerticalSpacings.xs)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        temperatureLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(regionNameLabel.snp.bottom).offset(VerticalSpacings.xl)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        temperatureImage.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(temperatureLabel)
            make.height.equalTo(Dimens.WidgetCellHeight)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
        pressureTitleLabel.snp.updateConstraints { (make) -> Void in
            make.bottom.equalTo(pressureLabel.snp.top).offset(-VerticalSpacings.xs)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(HorizontalSpacings.m)
        }
        pressureLabel.snp.updateConstraints { (make) -> Void in
            make.bottom.equalTo(dateLabel.snp.top).offset(-VerticalSpacings.l)
            make.centerX.equalTo(pressureTitleLabel)
        }
        humidityTitleLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(pressureTitleLabel)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        humidityLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(pressureLabel)
            make.centerX.equalTo(humidityTitleLabel)
        }
        windSpeedTitleLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(pressureTitleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-HorizontalSpacings.m)
        }
        windSpeedLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(pressureLabel)
            make.centerX.equalTo(windSpeedTitleLabel)
        }
        dateLabel.snp.updateConstraints { (make) -> Void in
            make.bottom.equalTo(progressBar.snp.top).offset(-VerticalSpacings.m)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showMockData() {
        cityNameLabel.apply {
            $0.text = "San Francisco"
            $0.isHidden = false
        }
        regionNameLabel.apply {
            $0.text = "CA"
            $0.isHidden = false
        }
        temperatureLabel.apply {
            $0.isHidden = false
            $0.text = "36 C"
            $0.isHidden = false
        }
        temperatureImage.apply {
            $0.isHidden = false
        }
        pressureTitleLabel.apply {
            $0.isHidden = false
        }
        pressureLabel.apply {
            $0.text = "1,010 hPa"
            $0.isHidden = false
        }
        humidityTitleLabel.apply {
            $0.isHidden = false
        }
        humidityLabel.apply {
            $0.text = "26%"
            $0.isHidden = false
        }
        windSpeedTitleLabel.apply {
            $0.isHidden = false
        }
        windSpeedLabel.apply {
            $0.text = "1.5 m/s"
            $0.isHidden = false
        }
        dateLabel.apply {
            $0.text = DateInRegion().dateAt(.endOfDay).toFormat(DATE_FORMAT)
            $0.isHidden = false
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
                log.error(error)
            })
        .subscribe())
    }
    
    private func fetchWeatherForLocation() {
        showProgressBar()
        subscribe(MetaWeatherRepo().getWeatherForWhereOnEarthId(whereOnEarthId: 2487956)
        .subscribeOnIo()
        .observeOnMain()
            .do(onNext: { (weatherForLocationResponse) in
                self.hideProgressBar()
                self.bindDataToView(weatherForLocationResponse)
            }, onError: { (error) in
                self.hideProgressBar()
                log.error(error)
            })
        .subscribe())
    }
    
    private func bindDataToView(_ response: WeatherForLocationResponse) {
        let weather = response.consolidatedWeather[0]
        let city = response.cityTitle
        let greaterRegion = response.parent.title
        let currentTemperature = "\(weather.maxTemp.rounded(numberOfDecimalPlaces: 2, rule: .up)) C"
        let humidity = "\(weather.humidity)%"
        let windSpeed = "\(weather.windSpeed.rounded(numberOfDecimalPlaces: 2, rule: .up)) m/s"
        let pressure = "\(weather.airPressure.rounded(numberOfDecimalPlaces: 2, rule: .up)) hPa"
        let dateTime = response.dateTime.parseDate()?.toFormat(DATE_FORMAT) ?? ""
        cityNameLabel.apply {
            $0.text = city
            $0.isHidden = false
        }
        regionNameLabel.apply {
            $0.text = greaterRegion
            $0.isHidden = false
        }
        temperatureLabel.apply {
            $0.text = currentTemperature
            $0.isHidden = false
        }
        temperatureImage.apply {
            $0.isHidden = false
        }
        pressureLabel.apply {
            $0.text = pressure
            $0.isHidden = false
        }
        pressureTitleLabel.apply {
            $0.isHidden = false
        }
        humidityLabel.apply {
            $0.text = humidity
            $0.isHidden = false
        }
        humidityTitleLabel.apply {
            $0.isHidden = false
        }
        windSpeedLabel.apply {
            $0.text = windSpeed
            $0.isHidden = false
        }
        windSpeedTitleLabel.apply {
            $0.isHidden = false
        }
        dateLabel.apply {
            $0.text = dateTime
            $0.isHidden = false
        }
        updateViewConstraints()
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
