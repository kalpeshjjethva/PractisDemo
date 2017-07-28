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
import AES256CBC

class AESAlgo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Method 1
        let encryptedString = "eyJpdiI6ImdqS0w3RDZqK053dVZYVzNMajVra0E9PSIsInZhbHVlIjoiS0ZJQnpCT3NsNW1SXC82V283RGRhUUE9PSIsIm1hYyI6ImNmYWU5YWViZmQwYWQyNWVhM2QzMzhkODY5ZjczNTg4ZDZmNTNlOTQ4ZTlmNzY5MTEyNTc0NDUzMjMyMjU4NTQifQ=="
        let password = "QNCvHG9djOwhkroukUgb/n8/JD8D4EI5//i1GQTugl0="
        
        let data = encryptedString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
      //  let passwords: Array<UInt8> = password.utf8.map {$0}
     //   let salt: Array<UInt8> = encryptedString.utf8.map {$0}
        
        
        let sadfasdfa = NSString()
        let printobject =  sadfasdfa.aes256Decrypt(withKey: encryptedString)
        print("sadf \(printobject)")
        
        let sadf = JFAes256Codec.decryptData(data, withKey: password)
        let backToString = String(data: sadf!, encoding: String.Encoding.utf8) as String!
        print("asdf \(backToString)")
        
        let objbase = JFBase64.decode(encryptedString)
        
        
        
        
        
        print("objbase \(objbase)")

        let backToStrsdfdsfing = String(data: objbase!, encoding: String.Encoding.ascii) as String!
        print("asdf \(backToStrsdfdsfing)")

        
        
        let Descencrypted = AESCrypt.decrypt(encryptedString, password: password)
        print(Descencrypted ?? "")
        method1(password: password, encryptedString: encryptedString)
    }
    func method2(password:String, encryptedString:String)
    {
        
//        self.encrypted.text = [FBEncryptorAES encryptBase64String:self.message.text
//            keyString:self.key.text
//            separateLines:[self.separateline isOn]];
//
        ///NSString* msg = [FBEncryptorAES decryptBase64String:self.encrypted.text
          //  keyString:self.key.text];
        
        
        
        let messg = FBEncryptorAES.decryptBase64String(encryptedString, keyString: password)
        print(messg)

    }
    func method1(password:String, encryptedString:String)
    {
        let str = "test"
        let password = AES256CBC.generatePassword()  // returns random 32 char string
        
        // get AES-256 CBC encrypted string
        
        print(password)
        let encrypted = AES256CBC.encryptString(str, password: password)
        
        
        print("\(encrypted)")
        
        // decrypt AES-256 CBC encrypted string
        //Password is for key in ios
        let decrypted = AES256CBC.decryptString(encrypted!, password: password)

        print("\(decrypted)")
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
