//
//  aaChart.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 28/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit

class aaChart: UIViewController ,UIWebViewDelegate {

    
    @IBOutlet weak var objWebView: UIWebView!
    @IBOutlet weak var chartView: UIView!
    
    var optionsJson: String?
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let htmlFile: String? = Bundle.main.path(forResource: "graph", ofType: "html")
        var htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        
        
        
        /*
         [{
         name: 'Gas',
         data: [5, 3, 4, 7, 2, 5, 3, 4, 7, 2, 5, 8]
         }, {
         name: 'Electicity',
         data: [5, 3, 4, 7, 2, 5, 3, 4, 7, 2, 5, 8]
         }, {
         name: 'Light',
         data: [5, 3, 4, 7, 2, 5, 3, 4, 7, 2, 5, 8]
         }]
         */
        
        var array = NSMutableArray()
        
        let dict = NSMutableDictionary()
        dict.setValue("Gas", forKey: "name")
        dict.setValue([5, 3, 4, 7, 2, 5, 3, 4, 7, 2, 5, 8], forKey: "data")
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("Electicity", forKey: "name")
        dict2.setValue([5, 3, 4, 7, 2, 5, 3, 4, 7, 2, 5, 8], forKey: "data")

        let dict3 = NSMutableDictionary()
        dict3.setValue("Light", forKey: "name")
        dict3.setValue([5, 3, 4, 7, 2, 5, 3, 4, 7, 2, 5, 8], forKey: "data")
        
        array.add(dict)
        array.add(dict2)
        array.add(dict3)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: array, options: (JSONSerialization.WritingOptions(rawValue: 0)))
        let theJSONText = NSString(data: jsonData,
                                   encoding: String.Encoding.ascii.rawValue)
        
        
        htmlString = htmlString?.replacingOccurrences(of: "kalpeshAAAAAData", with: theJSONText as! String)
        
        let jsString = NSString.localizedStringWithFormat("loadTheHighChartView('\(theJSONText!)');" as NSString)
        objWebView.stringByEvaluatingJavaScript(from: jsString as String)
        objWebView.loadHTMLString(htmlString!, baseURL: nil)
        objWebView.delegate = self
     }
}

extension AASerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}
