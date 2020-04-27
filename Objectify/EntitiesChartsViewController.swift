//
//  EntitiesChartsViewController.swift
//  Objectify
//
//  Created by ehsan sat on 4/26/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import Charts

class EntitiesChartsViewController: UIViewController {
    
    var entities: [Item] = []
    
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBarChart()

        // Do any additional setup after loading the view.
    }
    
    func updateBarChart () {
        var entries: [ChartDataEntry] = []
        var entitiesNames: [String] = []
        for (index, entities) in self.entities.enumerated() {
            let entry = BarChartDataEntry(x: Double(exactly: index)!, y: entities.sentimentValue)
            entries.append(entry)
            entitiesNames.append(entities.text)
        }
        print(entitiesNames)
        print(entries)
        let barChartDataSet = BarChartDataSet(entries: entries, label: "")
        barChartDataSet.drawValuesEnabled = true
        //        barChartDataSet.barBorderWidth
        //        barChartDataSet.barBorderWidth
        //        barChartDataSet.barShadowColor
        barChartDataSet.colors = ChartColorTemplates.joyful()
        
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChart.data = barChartData
        barChart.legend.enabled = true
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: entitiesNames)
        barChart.xAxis.granularityEnabled = true
        barChart.xAxis.granularity = 1
        barChart.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .easeInOutBounce)
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawGridLinesEnabled = false
        barChart.notifyDataSetChanged()
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
