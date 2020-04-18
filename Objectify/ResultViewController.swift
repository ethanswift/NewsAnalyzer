//
//  ResultViewController.swift
//  Objectify
//
//  Created by ehsan sat on 3/23/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResultViewController: UIViewController {
    
    var textViewText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func retrieveData () {
        let headers = [
            "x-rapidapi-host": "twinword-emotion-analysis-v1.p.rapidapi.com",
            "x-rapidapi-key": "64f5dfbfd7msh93c9160e6d0bd0fp1d3063jsn57d38ae04ac0",
            "content-type": "application/x-www-form-urlencoded"
        ]
        let postData = NSMutableData(data: textViewText.data(using: String.Encoding.utf8)!)
        var request = URLRequest(url: URL(fileURLWithPath: "https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/"))
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse)
            }
            print(data!)
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
