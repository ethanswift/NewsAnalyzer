//
//  ResultViewController.swift
//  Objectify
//
//  Created by ehsan sat on 3/23/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// entities table view

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items: [Item] = []
    
    var initialCell: Bool = true
    
    @IBOutlet weak var entitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entitiesTableView.delegate = self
        entitiesTableView.dataSource = self
        
//                entitiesTableView.sectionFooterHeight = 20
        entitiesTableView.sectionHeaderHeight = 20 // ??
        entitiesTableView.rowHeight = UITableView.automaticDimension
        entitiesTableView.estimatedRowHeight = 40
        entitiesTableView.separatorStyle = .none

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entitiesCell", for: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
