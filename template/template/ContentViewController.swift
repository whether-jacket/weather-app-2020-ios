import Foundation
import UIKit
import SnapKit

class ContentViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let button = UIButton()
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    let tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initializeViews()
        setConstraints()
    }

    private func initializeViews() {
        button.titleColorForNormal = UIColor.black
        button.setTitle("Hello world", for: .normal)
        view.addSubview(button)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // (optional) include this line if you want to remove the extra empty cell divider lines
        tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func setConstraints() {
        button.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(progressBar.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
        }
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(button.snp.bottom).offset(VerticalSpacings.m)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(HorizontalSpacings.m)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-HorizontalSpacings.m)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!

        // set the text from the data model
        cell.textLabel?.text = self.animals[indexPath.row]

        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}