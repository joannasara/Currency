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
        
    var data : [[String]] = [[String]]()
    var headingText : String = "Loading data..."
    var updateSuccesful = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "Currency Converter"
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh data")
        refreshControl?.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
                
        tableView.register(CCCurrencyCell.self, forCellReuseIdentifier: currencyCellID)
        tableView.register(CCAddRowCell.self, forCellReuseIdentifier: addCellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        CCPresenter.shared.view = self
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
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addCellID, for: indexPath) as! CCAddRowCell
                        
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
            CCPresenter.shared.tableViewDeleteRow(index: indexPath.row)
        }
    }
        
    func updateUI(data: [[String]], headingText: String) {
        self.data = data
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.headingText = headingText
    }
    
    @objc func handlePullToRefresh() {
        CCPresenter.shared.tableViewDidPullDown()
        refreshControl?.endRefreshing()
    }
}

