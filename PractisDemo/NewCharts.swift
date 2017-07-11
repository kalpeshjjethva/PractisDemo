//
//  NewCharts.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 07/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import Charts

class NewCharts: UIViewController, XBarChartDelegate {

    @IBOutlet weak var ViewxbarChart: XBarChart!
    
    @IBOutlet weak var roiChart: UIView!
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaseRenewalChart()
        ROIChart()
        expanceTracking()
    }
    
    func expanceTracking()
    {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold)

    }
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartDataSet.mode = .cubicBezier
        lineChartView.data = lineChartData
        
    }

    func ROIChart()
    {
        let itemArray = NSMutableArray()
        
        let item1 = XBarItem(dataNumber: (-80.93), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item1!)
        let item2 = XBarItem(dataNumber: (-107.04), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item2!)
        let item3 = XBarItem(dataNumber: (77.99), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item3!)
        let item4 = XBarItem(dataNumber: (57.48), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item4!)
        let item5 = XBarItem(dataNumber: (-89.91), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item5!)
        
        
        let item6 = XBarItem(dataNumber: (66.93), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item6!)
        let item7 = XBarItem(dataNumber: (7.04), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item7!)
        let item8 = XBarItem(dataNumber: (-77.99), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item8!)
        let item9 = XBarItem(dataNumber: (-28.48), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item9!)
        let item10 = XBarItem(dataNumber: (52.91), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item10!)
        
        
        let item11 = XBarItem(dataNumber: (-0.93), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item11!)
        let item12 = XBarItem(dataNumber: (-7.04), color: UIColor.green, dataDescribe: "test")
        itemArray.add(item12!)
        
        
        let barChart = XPositiveNegativeBarChart(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(375), height: CGFloat(200)), dataItemArray: itemArray, topNumber: 100, bottomNumber: (-170))
       // contentView.addSubview(barChart)
        self.roiChart.addSubview(barChart!)
    }
    
    func leaseRenewalChart()
    {
        let itemArray = NSMutableArray()
        
        let item1 = XBarItem(dataNumber: (50.93), color: UIColor.yellow, dataDescribe: "Jan")
        itemArray.add(item1!)
        let item2 = XBarItem(dataNumber: (90.04), color: UIColor.black, dataDescribe: "Feb")
        itemArray.add(item2!)
        let item3 = XBarItem(dataNumber: (80.99), color: UIColor.red, dataDescribe: "Mar")
        itemArray.add(item3!)
        let item4 = XBarItem(dataNumber: (110.48), color: UIColor.green, dataDescribe: "Apr")
        itemArray.add(item4!)
        let item5 = XBarItem(dataNumber: (92.91), color: UIColor.black, dataDescribe: "May")
        itemArray.add(item5!)
        
        let item6 = XBarItem(dataNumber: (74.93), color: UIColor.green, dataDescribe: "Jun")
        itemArray.add(item6!)
        let item7 = XBarItem(dataNumber: (50.04), color: UIColor.black, dataDescribe: "Jul")
        itemArray.add(item7!)
        let item8 = XBarItem(dataNumber: (44.99), color: UIColor.red, dataDescribe: "Aug")
        itemArray.add(item8!)
        let item9 = XBarItem(dataNumber: (28.48), color: UIColor.black, dataDescribe: "Sep")
        itemArray.add(item9!)
        let item10 = XBarItem(dataNumber: (52.91), color: UIColor.green, dataDescribe: "Oct")
        itemArray.add(item10!)
        //
        let item11 = XBarItem(dataNumber: (0.93), color: UIColor.black, dataDescribe: "Nov")
        itemArray.add(item11!)
        let item12 = XBarItem(dataNumber: (7.04), color: UIColor.black, dataDescribe: "Dec")
        itemArray.add(item12!)
        
        
        let sadfasdf = XBarChart(frame: CGRect(x: 0.0, y: 0.0, width: roiChart.frame.size.width, height: roiChart.frame.size.height), dataItemArray: itemArray, topNumber: 150, bottomNumber: 0)
        sadfasdf?.barChartDeleagte = self
        self.ViewxbarChart.addSubview(sadfasdf!)
    }
    func touchBar(atIdx idx: UInt) {
        NSLog("XBarChartDelegate touch Bat At idx %lu",idx);
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
