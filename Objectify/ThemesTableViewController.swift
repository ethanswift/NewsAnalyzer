//
//  ThemesTableViewController.swift
//  Objectify
//
//  Created by ehsan sat on 4/22/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit

class ThemesTableViewController: UITableViewController {
    
    var items: [Item] = []
    
    var themes: [Item] = []
    
    var initialCell: [Bool] = []
    
    @IBOutlet weak var chartsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillThemes()
        
        print("themes: ", themes)
        
        tableView.delegate = self
        tableView.dataSource = self

//        tableView.sectionFooterHeight = 20
        tableView.sectionHeaderHeight = 20
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
 
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func chartsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToThemesCharts", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        fillThemes()
        if self.themes.count != 0 {
            return themes.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func fillThemes () {
        if self.items.count != 0 {
            for item in self.items {
                if item.sentencePartType == "theme" {
                    self.themes.append(item)
                    let initial = true
                    self.initialCell.append(initial)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themesCell", for: indexPath)
        if initialCell[indexPath.section] == true {
        if indexPath.row == 0 {
            cell.textLabel?.text = self.themes[indexPath.section].text
            cell.textLabel?.textAlignment = .center
            cell.clipsToBounds = true
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.cornerRadius = 20
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
//            cell.contentView.sendSubviewToBack(<#T##view: UIView##UIView#>)
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Sentiment: " + " \(self.themes[indexPath.section].sentimentResult) " + " Value: " + " \(self.themes[indexPath.section].sentimentPolarity)" + " \(self.themes[indexPath.section].sentimentValue)"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Magnitude: \(self.themes[indexPath.section].magnitude)"
            cell.textLabel?.textAlignment = .center
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        } else {
            if indexPath.row == 1 {
                cell.textLabel?.text = self.themes[indexPath.section].sentenceText
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, ]
                cell.layer.cornerRadius = 20
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            } else if indexPath.row == 2 {
                
            } else if indexPath.row == 3 {
                
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
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToThemesCharts" {
            let vc = segue.destination as! ThemesChartsViewController
            vc.themes = themes
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

