//
//  MultipleLoader.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 20/06/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import Spring
import Lottie

class MultipleLoader: UIViewController {

    @IBOutlet weak var objjSpingView: SpringView!
    
    var objcounter = NSInteger()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        animationDemo()
    }
    func animationDemo()
    {
        let animationView = LOTAnimationView(name: "PinJump")
        animationView?.frame = CGRect(x: 300, y: 100, width: self.view.frame.size.width, height: 500)
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopAnimation = true
        self.view.addSubview(animationView!)
        animationView?.play()
    }
    @IBAction func btnAction(_ sender: UIButton) {
        
       // objjSpingView.curve = "linear"
        
        if objcounter == 0
        {
            objjSpingView.animation = "squeezeDown"
            objjSpingView.animate()
        }
        else if objcounter == 1
        {
            objjSpingView.animation = "squeezeLeft"
            objjSpingView.animate()
            
        }else if objcounter == 2
        {
            objjSpingView.animation = "slideLeft"
            objjSpingView.animate()
        }
        else if objcounter == 3
        {
            objjSpingView.animation = "fadeInLeft"
            objjSpingView.animate()
        }
        else if objcounter == 4
        {
            objjSpingView.animation = "fadeInRight"
            objjSpingView.animate()
        }
        else if objcounter == 5
        {
            objjSpingView.animation = "fadeInDown"
            objjSpingView.animate()
        }
        else if objcounter == 6
        {
            objjSpingView.animation = "zoomIn"
            objjSpingView.animate()
        }
        else if objcounter == 7
        {
            objjSpingView.animation = "zoomOut"
            objjSpingView.animate()
        }
        else if objcounter == 8
        {
            objjSpingView.animation = "flash"
            objjSpingView.animate()
        }
        else if objcounter == 9
        {
            objjSpingView.animation = "slideLeft"
            objjSpingView.animate()
            objcounter = -1
        }
        objcounter += 1
    }
    func wscall()
    {
        /*
        let authdict = NSMutableDictionary()
        authdict.setValue("wsuser@propertyapp.com", forKey: "ws_email"
        authdict.setValue("wsuser", forKey: "ws_password"
        
        let condition = NSMutableArray()
        condition.add("generalledgers.gl_isdelete =  0"
        
        let fields = NSMutableArray()
        fields.add("generalledgers.*"
        fields.add("properties.*"
        fields.add("propertytypes.*"
        fields.add("DATE_FORMAT(generalledgers.gl_date, '%Y') as Year"
        fields.add("DATE_FORMAT(generalledgers.gl_date, '%m') as Month"
        fields.add("DATE_FORMAT(properties.p_leaseto, '%Y') as PTYear"
        fields.add("DATE_FORMAT(properties.p_leaseto, '%m') as PTMonth"
        
        
        let contain = NSMutableArray()
        contain.add("properties"
        contain.add("propertytypes"
        
        let params = NSMutableDictionary()
        params.setValue(condition, forKey: "condition"
        params.setValue(fields, forKey: "fields"
        params.setValue(contain, forKey: "contain"
        
        
        let dict = NSMutableDictionary()
        dict.setValue(authdict, forKey: "auth"
        dict.setValue("get", forKey: "type"
        dict.setValue(params, forKey: "params"
        
        
        print(dict)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        
        
        
        let url = URL(string: "http://192.168.1.139/pmitsws/ledgers"!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data"
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            print(responseJSON)
            
            
            
            
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
        
        */
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
