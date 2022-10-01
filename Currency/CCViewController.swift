//
//  ViewController.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCViewController: UITableViewController {
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.tableView.backgroundColor = UIColor.gray
        tableView.register(CCTableViewCell.self, forCellReuseIdentifier: cellId)

        
//        self.navigationController!.navigationBar.barStyle = .black
//        self.navigationController!.navigationBar.isTranslucent = false
//        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    // MARK: - UITableView datasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}

