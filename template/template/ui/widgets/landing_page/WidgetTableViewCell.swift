import UIKit
import SwifterSwift

final class WidgetTableViewCell: UITableViewCell {

    public var widget: Widgets?
    private let widgetNameLabel = UILabel(textAppearance: .Subheadline)
    private let widgetImage = UIImageView()
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
        widgetNameLabel.text = nil
    }

    private func initializeViews() {
        selectionStyle = .none
        widgetNameLabel.apply {
            addSubview($0)
        }
        widgetImage.apply {
            addSubview($0)
        }
        dividerLine.apply {
            $0.backgroundColor = .black
            addSubview($0)
        }
        prepareForReuse()
    }

    private func setConstraints() {
        widgetNameLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(HorizontalSpacings.m)
        }
        widgetImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.widgetNameLabel.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(self).offset(HorizontalSpacings.m)
            make.right.equalTo(self).offset(-HorizontalSpacings.m)
        }
        dividerLine.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self)
            make.left.right.equalTo(self)
            make.height.equalTo(Dimens.HorizontalDividerLineHeight)
        }
    }
}

extension WidgetTableViewCell: UpdatableCell {

    func update(with item: Widgets) {
        self.widget = item
        widgetNameLabel.text = item.title
//        widgetImage.image = item.image //TODO
    }
}

protocol UpdatableCell {

    associatedtype ModelDataType

    func update(with item: ModelDataType)
}
