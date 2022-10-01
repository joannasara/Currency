//
//  ViewController.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCViewController: UITableViewController {
    
    
    let cellId = "cellId"
    
    var presenter = CCPresenter()
    var interactor = CCInteractor()
    
    var currencies : [String] = ["USD", "SGD", "CAD"]
    var conversionRates : [String:Double] = [:]
    var updateTime : Date?
    var updateSuccesful = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
                
        tableView.register(CCTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        presenter.interactor = interactor
        presenter.view = self
        
        interactor.requestExchangeRates(baseCurrency:"USD", baseCurrencyValue:100.0, completion: { [weak self] (response, updateTime, updateSuccessful) in
            
            self?.conversionRates = response
            self?.updateTime = updateTime
            self?.updateSuccesful = updateSuccessful
            
            DispatchQueue.main.async { 
                self?.tableView.reloadData()
            }
        })
    }
    


    // MARK: - UITableView datasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CCTableViewCell
        
        let currency = currencies[indexPath.row]
        cell.currencyNameLabel.text = currency
        
        if let value = conversionRates[currency] {
            cell.valueTextView.text = String(value)
        } else {
            cell.valueTextView.text =  "Loading..."
        }
        
        cell.presenter = presenter
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let time = updateTime else {
            return "Updating..."
        }
        
        if (!updateSuccesful) {
            return "Update failed!"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM YYYY, hh:mm:ss"
            let dateString = formatter.string(from: time)
            return "Last Update Time: \(dateString)"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CCTableViewCell.cellHeight
    }
    
    func updateTable(response: [String:Double], updateTime:Date, updateSuccessful:Bool) {
        // todojo weakify
        self.conversionRates = response
        self.updateTime = updateTime
        self.updateSuccesful = updateSuccessful
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

