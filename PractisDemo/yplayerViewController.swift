//
//  yplayerViewController.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 17/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit

class yplayerViewController: UIViewController {

    @IBOutlet weak var player: YTPlayerView!
    @IBOutlet weak var inventoryDetailView: UIView!
    
    @IBOutlet weak var inventoryXTrailing: NSLayoutConstraint!
    @IBOutlet weak var inventoryWidthConstant: NSLayoutConstraint!
    
    var lastXinventory = CGFloat()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

        
        let playerVars: [AnyHashable: Any] = ["playsinline": 1,"controls": 1,"autohide": 1,"showinfo": 0,"modestbrandin": 0]
        player.load(withVideoId: "uGyaDQo-xOk", playerVars: playerVars)

        // Do any additional setup after loading the view.
    }
    
       @IBAction func btnFurnitureAction(_ sender: UIButton) {
        
        if self.inventoryDetailView.frame.origin.x != 0
        {
            sender.setTitle("Hide", for: UIControlState.normal)

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                self.inventoryDetailView.frame.origin.x = 0
            });
            
            
        }else{
            
            sender.setTitle("ShowView", for: UIControlState.normal)

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                self.inventoryDetailView.frame.origin.x = 614
                

            });

            
        }
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
