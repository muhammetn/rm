//
//  SelectedServicesListVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class SelectedServicesListVC: UIViewController {
    
    let mainView = SelectedServicesListView()
    var rowCount = 10
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Выбранные услуги (7 услуги)"
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        //        MARK: - MyString attribute berip bolmady -
//        let attributes: [NSAttributedString.Key : Any] = [
//            NSAttributedString.Key.font: UIFont(font: .H1),
//            NSAttributedString.Key.foregroundColor: UIColor.white
//        ]
//
//        let countAttributes: [NSAttributedString.Key : Any] = [
//            NSAttributedString.Key.font: UIFont(font: .B1Regular),
//            NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor
//        ]
//        let str = "Выбранные услуги"
//        let count = "(7 услуги)"
//        let myString = NSMutableAttributedString(string: "\(str) \(count)", attributes: attributes)
//        myString.addAttributes(countAttributes, range: NSRange(location: str.count, length: count.count))
    }
    
}

extension SelectedServicesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 * KeyWords.widthRatio + 40
    }
    
}

extension SelectedServicesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case rowCount-1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormsCell.identifier, for: indexPath) as! FormsCell
            cell.selectionStyle = .none
            return cell
        case rowCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCheckCell.identifier, for: indexPath) as! TimeCheckCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectedServicesCell.identifier, for: indexPath) as! SelectedServicesCell
//            cell.backgroundColor = .green
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PriceFooterView.identifier) as! PriceFooterView
        footer.clickCallback = { [weak self] in
            guard let self = self else {
                return
            }
            let vc = DatePickerVC()
            self.show(vc, sender: self)
        }
        return footer
    }
    
}

