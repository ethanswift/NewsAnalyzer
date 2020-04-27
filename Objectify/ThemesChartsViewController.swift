//
//  ThemesChartsViewController.swift
//  Objectify
//
//  Created by ehsan sat on 4/26/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import Charts

class ThemesChartsViewController: UIViewController {
    
    var themes: [Item] = []
    
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBarChart()
        // Do any additional setup after loading the view.
    }
    
    func updateBarChart () {
        var entries: [ChartDataEntry] = []
        var themesNames: [String] = []
        for (index, theme) in self.themes.enumerated() {
            let entry = BarChartDataEntry(x: Double(exactly: index)!, y: theme.sentimentValue)
            entries.append(entry)
            themesNames.append(theme.text)
        }
        let barChartDataSet = BarChartDataSet(entries: entries, label: "")
        barChartDataSet.drawValuesEnabled = false
//        barChartDataSet.barBorderWidth
//        barChartDataSet.barBorderWidth
//        barChartDataSet.barShadowColor
        barChartDataSet.colors = ChartColorTemplates.joyful()
        
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChart.data = barChartData
        barChart.legend.enabled = true
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: themesNames)
        barChart.xAxis.granularityEnabled = true
        barChart.xAxis.granularity = 1
        barChart.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .easeInOutBounce)
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawGridLinesEnabled = false
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
