//
//  AboutViewController.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {

    @IBOutlet var aboutTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

         // Remove unwanted table view lines
         aboutTableView.tableFooterView = UIView()
    }
    
}
