//
//  highChartWithPod.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 28/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import Highcharts


class highChartWithPod: UIViewController {
    
    var chartView = HIGChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        chartView = HIGChartView(frame: CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y + 20, width: view.bounds.size.width, height: 300.0))
        let options = HIOptions()
        chartView.backgroundColor = UIColor.red
        let chart = HIChart()
        chart.type = "column"
        options.chart = chart
        let title = HITitle()
        title.text = "Demo chart"
        options.title = title
        let series = HIColumn()
        series.data = [49.9, 71.5, 106.4, 129.2, 144, 176, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
        options.series = [series]
        chartView.options = options
        view.addSubview(chartView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
