import UIKit
import SwifterSwift

final class CityTableViewCell: UITableViewCell {

    public static let IDENTIFIER = "CityTableViewCell"
    private static let REORDER_ICON_IDENTIFIER = "Reorder"
    public var cityTableItem: CityTableItem?
    private let cityNameLabel = UILabel(textAppearance: .Subheadline)
    private let regionNameLabel = UILabel(textAppearance: .Subheadline)
    private let dividerLine = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        initializeViews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
        regionNameLabel.text = nil
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if ThemeManager.instance.getCurrentTheme().isLight {
            return
        }
        if !editing {
            return
        }
        for view in subviews where view.description.contains(CityTableViewCell.REORDER_ICON_IDENTIFIER) {
            for case let subview as UIImageView in view.subviews {
                subview.image = UIImage(named: Images.HamburgerLight)
            }
        }
    }

    private func initializeViews() {
        selectionStyle = .none
        cityNameLabel.apply {
            addSubview($0)
        }
        regionNameLabel.apply {
            addSubview($0)
        }
        dividerLine.apply {
            $0.backgroundColor = ThemeManager.instance.getCurrentTheme().dividerColor
            addSubview($0)
        }
        prepareForReuse()
    }

    private func setConstraints() {
        cityNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(VerticalSpacings.m)
            make.left.equalTo(self).offset(HorizontalSpacings.xl)
            make.right.equalTo(self).offset(-HorizontalSpacings.m)
        }
        regionNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.cityNameLabel.snp.bottom).offset(VerticalSpacings.s)
            make.left.equalTo(self).offset(HorizontalSpacings.xl)
            make.right.equalTo(self).offset(-HorizontalSpacings.m)
        }
        dividerLine.snp.makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(Dimens.HorizontalDividerLineHeight)
        }
    }
}

extension CityTableViewCell: UpdatableCellView {

    func update(with item: CityTableItem) {
        cityTableItem = item
        cityNameLabel.text = item.cityName
        regionNameLabel.text = item.regionName
    }
}

protocol UpdatableCellView {

    associatedtype ModelDataType

    func update(with item: ModelDataType)
}
