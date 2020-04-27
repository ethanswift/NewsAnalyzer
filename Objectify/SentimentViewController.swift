//
//  SentimentViewController.swift
//  Objectify
//
//  Created by ehsan sat on 4/18/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit

// core sentences table view

class SentimentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [Item] = []
    
    var coreSentences: [Item] = []
    
    var doc: [Doc] = [] // bringing doc sentiment values as one of the core sentences here; also categories shoudl inserted here
    
    @IBOutlet weak var chartsButton: UIBarButtonItem!
    
    
//    var initialCell: Bool = true
    
    @IBOutlet weak var sentencesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillCoreSentences()
        
        print("core sentences: ", coreSentences)
        
        sentencesTableView.delegate = self
        sentencesTableView.dataSource = self
        
        //                entitiesTableView.sectionFooterHeight = 20
        sentencesTableView.sectionHeaderHeight = 20
        sentencesTableView.rowHeight = UITableView.automaticDimension
        sentencesTableView.estimatedRowHeight = 40
        sentencesTableView.separatorStyle = .none
   
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chartsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSentencesCharts", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return coreSentences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentimentCell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = self.coreSentences[indexPath.section].text
            cell.textLabel?.textAlignment = .center
            cell.clipsToBounds = true
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.cornerRadius = 20
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            //            cell.contentView.sendSubviewToBack(<#T##view: UIView##UIView#>)
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Sentiment: " + " \(self.coreSentences[indexPath.section].sentimentResult) " + " Value: " + " \(self.coreSentences[indexPath.section].sentimentPolarity)" + " \(self.coreSentences[indexPath.section].sentimentValue)"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Magnitude: \(self.coreSentences[indexPath.section].magnitude)"
            cell.textLabel?.textAlignment = .center
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        return cell
    }
    
    func fillCoreSentences () {
        if self.items.count != 0 {
            for item in self.items {
                if item.sentencePartType == "coreSentence" {
                    self.coreSentences.append(item)
                }
            }
        }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSentencesCharts" {
            let vc = segue.destination as! SentencesChartsViewController
            vc.coreSentences = coreSentences
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
