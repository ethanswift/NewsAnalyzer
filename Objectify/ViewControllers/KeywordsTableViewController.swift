//
//  KeywordsTableViewController.swift
//  Objectify
//
//  Created by ehsan sat on 4/22/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit

class KeywordsTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    var items: [Item] = []
    
    var keywords: [Item] = []
    
    var initialCell: [Bool] = []
    
    @IBOutlet weak var chartsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillKeywords()
        
        tableView.delegate = self
        tableView.dataSource = self
        tabBarController?.delegate = self
        
        tableView.sectionHeaderHeight = 20
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        
        self.tabBarController?.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir", size: 16)!], for: .normal)
        self.tabBarController?.tabBarItem.image = #imageLiteral(resourceName: "key")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func chartsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToKeywordsCharts", sender: self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return keywords.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func fillKeywords () {
        if self.items.count != 0 {
            for item in items {
                if item.sentencePartType == "keyword" {
                    self.keywords.append(item)
                    let initial = true
                    self.initialCell.append(initial)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordsCell", for: indexPath)
        if initialCell[indexPath.section] == true {
            if self.keywords[indexPath.section].sentimentResult == "positive" {
                cell.backgroundColor = #colorLiteral(red: 0.2040559649, green: 0.7372421622, blue: 0.6007294059, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if self.keywords[indexPath.section].sentimentResult == "neutral" {
                cell.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 0.1490027606, green: 0.1490303874, blue: 0.1489966214, alpha: 1)
            } else if self.keywords[indexPath.section].sentimentResult == "negative" {
                cell.backgroundColor = #colorLiteral(red: 0.920953393, green: 0.447560966, blue: 0.4741248488, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        if indexPath.row == 0 {
            cell.textLabel?.text = self.keywords[indexPath.section].text
            cell.textLabel?.textAlignment = .center
            cell.clipsToBounds = true
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.cornerRadius = 20
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Sentiment: " + " \(self.keywords[indexPath.section].sentimentResult) " + " Value: " + " \(self.keywords[indexPath.section].sentimentPolarity)" + " \(self.keywords[indexPath.section].sentimentValue)"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Magnitude: \(self.keywords[indexPath.section].magnitude)"
            cell.textLabel?.textAlignment = .center
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = self.keywords[indexPath.section].sentenceText
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.layer.cornerRadius = 20
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            } else if indexPath.row == 1 {
                cell.textLabel?.text = ""
                cell.textLabel?.numberOfLines = 0
            } else if indexPath.row == 2 {
                cell.textLabel?.text = ""
                cell.textLabel?.numberOfLines = 0 
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.layer.cornerRadius = 20
            }
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        initialCell[indexPath.section] = !initialCell[indexPath.section]
        tableView.reloadData()
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBarController?.tabBar.frame.size.height = 80
        self.tabBarController?.tabBar.frame.origin.y = view.frame.height - 80
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToKeywordsCharts" {
            let vc = segue.destination as! KeywordsChartsViewController
            vc.keywords = keywords
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
