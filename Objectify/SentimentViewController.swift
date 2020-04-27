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
        
        sentencesTableView.delegate = self
        sentencesTableView.dataSource = self
        
        //                entitiesTableView.sectionFooterHeight = 20
        sentencesTableView.sectionHeaderHeight = 20
        sentencesTableView.rowHeight = UITableView.automaticDimension
        sentencesTableView.estimatedRowHeight = 40
        sentencesTableView.separatorStyle = .none
        
        fillCoreSentences()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chartsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSentencesCharts", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentimentCell", for: indexPath)
        return cell
    }
    
    func fillCoreSentences () {
        if self.items.count != 0 {
            for item in self.items {
                if item.sentencePartType == "coreSentences" {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
