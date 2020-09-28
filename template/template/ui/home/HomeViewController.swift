import UIKit
import SnapKit
import SwiftDate

class HomeViewController: BaseViewController {

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
        fetchWeatherForLocation()
//        fetchCities()
//        showMockData()
    }

    private func initializeViews() {
        cityNameLabel.apply {
            $0.setTextAppearance(.Headline)
            view.addSubview($0)
        }
        regionNameLabel.apply {
            $0.setTextAppearance(.Subheadline)
            view.addSubview($0)
        }
        temperatureLabel.apply {
            $0.setTextAppearance(.Subheadline)
            view.addSubview($0)
        }
        temperatureImage.apply {
            view.addSubview($0)
        }
        pressureTitleLabel.apply {
            $0.setTextAppearance(.Body)
            $0.text = Strings.Pressure
            $0.setUnderlined()
            view.addSubview($0)
        }
        pressureLabel.apply {
            $0.setTextAppearance(.Caption1)
            view.addSubview($0)
        }
        humidityTitleLabel.apply {
            $0.setTextAppearance(.Body)
            $0.text = Strings.Humidity
            $0.setUnderlined()
            view.addSubview($0)
        }
        humidityLabel.apply {
            $0.setTextAppearance(.Caption1)
            view.addSubview($0)
        }
        windSpeedTitleLabel.apply {
            $0.setTextAppearance(.Body)
            $0.text = Strings.WindSpeed
            $0.setUnderlined()
            view.addSubview($0)
        }
        windSpeedLabel.apply {
            $0.setTextAppearance(.Caption1)
            view.addSubview($0)
        }
        dateLabel.apply {
            $0.setTextAppearance(.Subheadline)
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        cityNameLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.top).offset(VerticalSpacings.m)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-VerticalSpacings.m)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showMockData() {
        cityNameLabel.apply {
            $0.text = "San Francisco"
        }
        regionNameLabel.apply {
            $0.text = "CA"
        }
        temperatureLabel.apply {
            $0.text = "36 C"
        }
//        temperatureImage.apply {
            
//        }
        pressureLabel.apply {
            $0.text = "1,010 hPa"
        }
        humidityLabel.apply {
            $0.text = "26%"
        }
        windSpeedLabel.apply {
            $0.text = "1.5 m/s"
        }
        dateLabel.apply {
            $0.text = "July 4th 2020"
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
        showProgressBar()
        subscribe(MetaWeatherRepo().getWeatherForWhereOnEarthId(whereOnEarthId: 2487956)
        .subscribeOnIo()
        .observeOnMain()
            .do(onNext: { (weatherForLocationResponse) in
                self.hideProgressBar()
                self.bindDataToView(weatherForLocationResponse)
            }, onError: { (error) in
                self.hideProgressBar()
                log.debug(error)
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
        let dateTime = response.dateTime.parseDate()?.toFormat(YearMonthDay.MMM_D_YYYY_SPACE.rawValue) ?? ""
        cityNameLabel.apply {
            $0.text = city
        }
        regionNameLabel.apply {
            $0.text = greaterRegion
        }
        temperatureLabel.apply {
            $0.text = currentTemperature
        }
//        temperatureImage.apply {
//        }
        pressureLabel.apply {
            $0.text = pressure
        }
        humidityLabel.apply {
            $0.text = humidity
        }
        windSpeedLabel.apply {
            $0.text = windSpeed
        }
        dateLabel.apply {
            $0.text = dateTime
        }
    }
}
