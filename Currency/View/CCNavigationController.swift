//
//  CCNavigationController.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CCPresenter.shared.navigationController = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
