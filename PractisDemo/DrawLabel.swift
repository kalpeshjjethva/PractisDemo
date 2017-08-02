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
//    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var lblText: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        let htmlString = "<font size=\"15\">Purchased on <font color=\"red\">16/05/2015</font> Maintained by 21electrical lastServiced <font color=\"red\">11/07/2017</font></font>"
        
        let encodedData = htmlString.data(using: String.Encoding.utf8)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
        
        lblText.attributedText = attributedString

    }
    
    func setAttributedText(font:UIFont, staticText:String, dynamicText: String, StaticColor:UIColor, DynamicColor: UIColor)-> NSMutableAttributedString
    {
        let yourAttributes = [NSForegroundColorAttributeName: StaticColor, NSFontAttributeName: font ] as [String : Any]
        let yourOtherAttributes = [NSForegroundColorAttributeName: DynamicColor, NSFontAttributeName: font] as [String : Any]
        
        let partOne = NSMutableAttributedString(string: staticText, attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: dynamicText, attributes: yourOtherAttributes)
        let combination = NSMutableAttributedString()
        
        combination.append(partOne)
        combination.append(partTwo)
        
        return combination
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
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
