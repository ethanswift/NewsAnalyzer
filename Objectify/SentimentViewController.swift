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
    
    @IBOutlet weak var sentencesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentencesTableView.delegate = self
        sentencesTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func fillCoreSentences () {
        if self.items.count != 0 {
            for item in self.items {
                if item.sentencePartType == "coreSentences" {
                    
                }
            }
        }
        
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
