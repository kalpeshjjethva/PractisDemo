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
    @IBOutlet weak var wsCharts: UIView!
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    let dollars1 = [1453.0,-2352,5431,1442] // last value = first value of next dataset
    let dollars2 = [1442.0,2234,8763,4453] // last value = first value of next dataset
    let dollars3 = [4453.0,3456,7843,5678] // last value = first value of next dataset

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //leaseRenewalChart()
        //LedgerChart()
        //expanceTracking()
        
        newROICharts()
    }
    //  Converted with Swiftify v1.0.6395 - https://objectivec2swift.com/
    func createDemoDatas(_ count: Int) -> [Any] {
        var aryObj = [Any]()
        aryObj.append("Jan")
        aryObj.append("Feb")
        aryObj.append("Mar")
        aryObj.append("Apr")
        aryObj.append("May")
        aryObj.append("Jun")
        aryObj.append("Jul")
        aryObj.append("Aug")
        aryObj.append("Sep")
        aryObj.append("Oct")
        aryObj.append("Nov")
        aryObj.append("Dec")
        aryObj.append("50")
        aryObj.append("60")
        aryObj.append("70")
        
        aryObj.append("200")
        aryObj.append("-150")
        aryObj.append("-100")
        aryObj.append("100")
        aryObj.append("-20")
        aryObj.append("600")
        aryObj.append("-40")
        aryObj.append("60")
        aryObj.append("230")
        aryObj.append("-500")
        aryObj.append("60")
        aryObj.append("230")
        
        var arr = [Any]()
        for i in 0..<count {
            var lfcObj = WSChartObject()
            lfcObj.name = "ROI"
            lfcObj.xValue = aryObj[i]
            //[NSString stringWithFormat:@"%d",i];
            // lfcObj.yValue = [NSNumber numberWithFloat: arc4random() % 400];
            lfcObj.yValue = aryObj[i + 12]
            print("y value print \(aryObj[i + 12])")
            var data: [AnyHashable: Any] = [
                "ROI" : lfcObj
            ]
            
            arr.append(data)
        }
        return arr
    }
    func createColorDict() -> [AnyHashable: Any] {
        let colorDict: [AnyHashable: Any] = [
            "ROI" : UIColor.red
        ]
        
        return colorDict
    }

    func newROICharts()
    {
        var areaChart = WSAreaChartView(frame: CGRect(x: CGFloat(-7), y: CGFloat(-20), width: CGFloat(800.0), height: CGFloat(wsCharts.frame.size.height + 100.0)))
        var arr: [Any] = createDemoDatas(12)
        var colorDict: [AnyHashable: Any] = createColorDict()
        areaChart.rowWidth = 22.0
        areaChart.title = "Pyanfield's Area Chart"
        areaChart.showZeroValueOnYAxis = false
        areaChart.drawChart(arr, withColor: colorDict)
        areaChart.backgroundColor = UIColor.black
        
//        self.view.addSubview(areaChart)
        wsCharts.addSubview(areaChart)
    }
    func expanceTracking()
    {
        let months = ["Jan", "Feb", "Mar", "Apr"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChartData(months: months)
        
       // setChart(lineChartView, dataPoints: dollars1, values: dollars2)
        

    }
    fileprivate func seatChart(_ lineChartView: LineChartView, dataPoints: [Double], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Altitude")
        lineChartDataSet.setColor(UIColor.blue)
        // lineChartDataSet.drawCubicEnabled = true
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.lineWidth = 1.0
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.highlightColor = UIColor.red
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = true
        
        var dataSets = [IChartDataSet]()
        dataSets.append(lineChartDataSet)
        let lineChartData = LineChartData(dataSets: dataSets)
        lineChartView.data = lineChartData
    }
    func setChartData(months : [String]) {
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< months.count {
            yVals1.append(ChartDataEntry(x: dollars1[i], y: Double(i)))
        }
        
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "First Set")
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5))
        set1.setCircleColor(UIColor.red)
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0
        set1.fillAlpha = 1
        set1.fillColor = UIColor.red
        set1.drawFilledEnabled = true
        
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< months.count {
            yVals2.append(ChartDataEntry(x: dollars2[i], y: Double(i)))
        }
        
        let set2: LineChartDataSet = LineChartDataSet(values: yVals2, label: "Second Set")
        set2.axisDependency = .left // Line will correlate with left axis values
        set2.setColor(UIColor.green.withAlphaComponent(0.5))
        set2.setCircleColor(UIColor.green)
        set2.lineWidth = 2.0
        set2.circleRadius = 6.0
        set2.fillAlpha = 1
        set2.fillColor = UIColor.green
        set2.drawFilledEnabled = true
        
        var yVals3 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< months.count {
            yVals3.append(ChartDataEntry(x: dollars3[i], y: Double(i)))
        }
        
        let set3: LineChartDataSet = LineChartDataSet(values: yVals3, label: "Second Set")
        set3.axisDependency = .left // Line will correlate with left axis values
        set3.setColor(UIColor.blue.withAlphaComponent(0.5))
        set3.setCircleColor(UIColor.blue)
        set3.lineWidth = 2.0
        set3.circleRadius = 6.0
        set3.fillAlpha = 65 / 255.0
        set3.fillColor = UIColor.blue
        set3.drawFilledEnabled = true
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
       // dataSets.append(set2)
        //dataSets.append(set3)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        //let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
        
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        self.lineChartView.data = data
        
    }
    func ROIChartsNew()
    {
        
    }

    func LedgerChart()
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
