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

// entities collection view

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var items: [Item] = []
    
    @IBOutlet weak var entitiesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        entitiesCollectionView.delegate = self
        entitiesCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
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
