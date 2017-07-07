//
//  NewCharts.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 07/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit

class NewCharts: UIViewController, XBarChartDelegate {

    @IBOutlet weak var ViewxbarChart: XBarChart!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let itemArray = NSMutableArray()
        
        let item1 = XBarItem(dataNumber: (50.93), color: UIColor.green, dataDescribe: "MAC Os")
        itemArray.add(item1!)
        let item2 = XBarItem(dataNumber: (90.04), color: UIColor.green, dataDescribe: "Win10")
        itemArray.add(item2!)
        let item3 = XBarItem(dataNumber: (80.99), color: UIColor.red, dataDescribe: "Win8")
        itemArray.add(item3!)
        let item4 = XBarItem(dataNumber: (110.48), color: UIColor.green, dataDescribe: "WinXP")
        itemArray.add(item4!)
        let item5 = XBarItem(dataNumber: (92.91), color: UIColor.green, dataDescribe: "Win7")
        itemArray.add(item5!)
        
        let item6 = XBarItem(dataNumber: (74.93), color: UIColor.green, dataDescribe: "MAC Os")
        itemArray.add(item6!)
        let item7 = XBarItem(dataNumber: (50.04), color: UIColor.green, dataDescribe: "Win10")
        itemArray.add(item7!)
        let item8 = XBarItem(dataNumber: (44.99), color: UIColor.red, dataDescribe: "Win8")
        itemArray.add(item8!)
        let item9 = XBarItem(dataNumber: (28.48), color: UIColor.green, dataDescribe: "WinXP")
        itemArray.add(item9!)
        let item10 = XBarItem(dataNumber: (52.91), color: UIColor.green, dataDescribe: "Win7")
        itemArray.add(item10!)
        //
        let item11 = XBarItem(dataNumber: (0.93), color: UIColor.green, dataDescribe: "MAC Os")
        itemArray.add(item11!)
        let item12 = XBarItem(dataNumber: (7.04), color: UIColor.green, dataDescribe: "Win10")
        itemArray.add(item12!)
        
        
        
        
        //XBarChart *barChart = [[XBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@150 bottomNumber:@(0)];
        //barChart.barChartDeleagte = self;
        //[self.contentView addSubview:barChart];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        let sadfasdf = XBarChart(frame: ViewxbarChart.frame, dataItemArray: itemArray, topNumber: 150, bottomNumber: 0)
        sadfasdf?.barChartDeleagte = self
        
        self.view.addSubview(sadfasdf!)
        
        // Do any additional setup after loading the view.
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
