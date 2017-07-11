//
//  CustomCalloutView.swift
//  CustomCalloutView
//
//  Created by Malek T. on 3/10/16.
//  Copyright © 2016 Medigarage Studios LTD. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var starbucksImage: UIImageView!
    @IBOutlet var starbucksName: UILabel!
    @IBOutlet var starbucksAddress: UILabel!
    @IBOutlet var starbucksPhone: UILabel!
    
    var objString:String?
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomCalloutView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if objString != nil{
            
            cell.textLabel?.text = objString
        }else{
            cell.textLabel?.text = "Kalpesh"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did selectec tap")
    }
}
