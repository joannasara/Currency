//
//  ViewController.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCViewController: UITableViewController {
    
    
    let currencyCellID = "currencyCellID"
    let addCellID = "addCellID"
    
    var presenter = CCPresenter()
    
    var data : [[String]] = [[String]]()
    var headingText : String = "Loading data..."
    var updateSuccesful = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
                
        tableView.register(CCCurrencyCell.self, forCellReuseIdentifier: currencyCellID)
        tableView.register(CCAddRowCell.self, forCellReuseIdentifier: addCellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        presenter.view = self
    }
    


    // MARK: - UITableView datasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row < data.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellID, for: indexPath) as! CCCurrencyCell
            
            cell.currencyLabel.text = data[indexPath.row][0]
            cell.valueTextView.text = data[indexPath.row][1]
            cell.presenter = presenter
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addCellID, for: indexPath) as! CCAddRowCell
            
            cell.presenter = presenter
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headingText
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CCCurrencyCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter.tableViewDeleteRow(index: indexPath.row)
        }
    }
        
    func updateUI(data: [[String]], headingText: String) {
        self.data = data
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.headingText = headingText
    }
    
    func showPopup() {
        let popupWindow = CCCurrencyPickerPopupWindow(presenter: presenter)
        presenter.popupWindow = popupWindow
        self.present(popupWindow, animated: true, completion: nil)
    }
}

