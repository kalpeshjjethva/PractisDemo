//
//  AESAlgo.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 03/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import CryptoSwift
import RNCryptor

class AESAlgo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Method 1
        let encrypted = AESCrypt.encrypt("test", password: "test")
        print("encrypted \(encrypted)")
        let sdfDescencrypted = AESCrypt.decrypt(encrypted, password: "test")
        print("sdfDescencrypted \(sdfDescencrypted)")
        //Method 2
       // let Descencrypted = AESCrypt.decrypt("eyJpdiI6IkgybUhvZUNtYXJSaEFubnl4RFFOQmc9PSIsInZhbHVlIjoiZFR6ZDBnZlhVRDcxeEVRcHV2QjJsZz09IiwibWFjIjoiYzdmYjFmYWQ2MGYxOTQzYTZkZGFhZTUyN2Y0MGRlZWEyMzFlMmVmOWY2OWZlZjkzYTU4YjQxNTQ3ZjRhOWJhYyJ9", password: "eYx7il2BNYdecDbtmg7s52AL5WUpKI4VfSqm+UHFfgI=")
       // print("Descencrypted \(Descencrypted)")
        
        
        //Method 3 
        let input = "eyJpdiI6IkgybUhvZUNtYXJSaEFubnl4RFFOQmc9PSIsInZhbHVlIjoiZFR6ZDBnZlhVRDcxeEVRcHV2QjJsZz09IiwibWFjIjoiYzdmYjFmYWQ2MGYxOTQzYTZkZGFhZTUyN2Y0MGRlZWEyMzFlMmVmOWY2OWZlZjkzYTU4YjQxNTQ3ZjRhOWJhYyJ9"
        let data = input.data(using: .utf8)!
        let password = "eYx7il2BNYdecDbtmg7s52AL5WUpKI4VfSqm+UHFfgI="
        let decryptor = RNCryptor.Decryptor(password: password)
        let plaintext = NSMutableData()
       // let sdf = try! plaintext.append(decryptor.decrypt(data: data))
      //  print("sadf \(sdf)")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnDecrptionAction(_ sender: UIButton) {
    }

    @IBAction func btnEncrptionActino(_ sender: UIButton) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DrawRout") as! DrawRout
        
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.5
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: false)
        

        
        
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
