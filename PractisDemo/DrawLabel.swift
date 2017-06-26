//
//  DrawLabel.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 25/06/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import Charts

class DrawLabel: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0,20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold)
    }
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        lineChartDataSet.mode = .cubicBezier
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
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
public class VerticalAlignLabel: UILabel {
    enum VerticalAlignment {
        case top
        case middle
        case bottom
    }
    
    var verticalAlignment : VerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)
        
        if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
            switch verticalAlignment {
            case .top:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        } else {
            switch verticalAlignment {
            case .top:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        }
    }
    
    override public func drawText(in rect: CGRect) {
        let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: r)
    }
}
