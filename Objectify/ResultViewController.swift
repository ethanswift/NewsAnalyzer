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
    
    var entities: [Item] = []
    
    var initialCell: [Bool] = []
    
    @IBOutlet weak var chartsButton: UIBarButtonItem!
    
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
    
    @IBAction func chartsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToEntitiesCharts", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entitiesCell", for: indexPath)
        if initialCell[indexPath.section] == true {
            if indexPath.row == 0 {
                cell.textLabel?.text = self.entities[indexPath.section].text
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.layer.cornerRadius = 20
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
                //            cell.contentView.sendSubviewToBack(<#T##view: UIView##UIView#>)
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Sentiment: " + " \(self.entities[indexPath.section].sentimentResult) " + " Value: " + " \(self.entities[indexPath.section].sentimentPolarity)" + " \(self.entities[indexPath.section].sentimentValue)"
                cell.textLabel?.textAlignment = .center
                cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Magnitude: \(self.entities[indexPath.section].magnitude)"
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 20
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            }
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = self.entities[indexPath.section].sentenceText
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, ]
                cell.layer.cornerRadius = 20
            } else if indexPath.row == 1 {
                
            } else if indexPath.row == 2 {
                
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        fillEntities()
        return entities.count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        initialCell[indexPath.section] = !initialCell[indexPath.section]
        tableView.reloadData()
    }
    
    func fillEntities () {
        if self.items.count != 0 {
            for item in items {
                if item.sentencePartType == "entity" {
                    entities.append(item)
                    let inital = true
                    initialCell.append(inital)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEntitiesCharts" {
            let vc = segue.destination as! EntitiesChartsViewController
            vc.entities = entities
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   

}
