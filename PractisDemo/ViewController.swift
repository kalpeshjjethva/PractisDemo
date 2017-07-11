//
//  ViewController.swift
//  PractisDemo
//
//  Createdsdf by Mehul Solanki on 29/05/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import ASPVideoPlayer
import MediaPlayer

class ViewController: UIViewController {

    
    @IBOutlet weak var videoPlayer: ASPVideoPlayerView!

    @IBOutlet weak var defaultView: UIView!
    
    @IBOutlet weak var objSuperView: UIView!
    var isFull = Bool()
    
    var moviePlayer : MPMoviePlayerController!

    var ObjLastSize = CGRect()
    
    @IBOutlet weak var btnPlayPause: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        wscall()
    }
    
    func wscall()
    {
        /*
         {
         "auth": {
         "ws_email": "wsuser@propertyapp.com",
         "ws_password": "wsuser"
         }
         */
        let authdict = NSMutableDictionary()
        authdict.setValue("wsuser@propertyapp.com", forKey: "ws_email")
        authdict.setValue("wsuser", forKey: "ws_password")
        
        let condition = NSMutableArray()
        condition.add("generalledgers.gl_isdelete =  0")
        
        let fields = NSMutableArray()
        fields.add("generalledgers.*")
        fields.add("properties.*")
        fields.add("propertytypes.*")
        fields.add("DATE_FORMAT(generalledgers.gl_date, '%Y') as Year")
        fields.add("DATE_FORMAT(generalledgers.gl_date, '%m') as Month")
        fields.add("DATE_FORMAT(properties.p_leaseto, '%Y') as PTYear")
        fields.add("DATE_FORMAT(properties.p_leaseto, '%m') as PTMonth")
        
        
        let contain = NSMutableArray()
        contain.add("properties")
        contain.add("propertytypes")
        
        let params = NSMutableDictionary()
        params.setValue(condition, forKey: "condition")
        params.setValue(fields, forKey: "fields")
        params.setValue(contain, forKey: "contain")
        
        
        let dict = NSMutableDictionary()
        dict.setValue(authdict, forKey: "auth")
        dict.setValue("get", forKey: "type")
        dict.setValue(params, forKey: "params")
        
        
        print(dict)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        
        
        let url = URL(string: "http://propertyappws.secretdemo.com/ledgers")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var response: URLResponse?
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                print("responseJSON \(responseJSON)")
            }
        } catch (let e) {
            print(e)
        }
        
        /*
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
         guard let data = data, error == nil else {
         print(error?.localizedDescription ?? "No data")
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
    func playVideo()
    {
        ObjLastSize = objSuperView.frame
        
        isFull = false
        let videoURL = URL(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
        
        self.moviePlayer = MPMoviePlayerController(contentURL: videoURL)
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.defaultView.frame.size.width, height: self.defaultView.frame.size.height)
        moviePlayer.view.sizeToFit()
        moviePlayer.scalingMode = MPMovieScalingMode.fill
        moviePlayer.isFullscreen = true
        moviePlayer.controlStyle = MPMovieControlStyle.none
        moviePlayer.movieSourceType = MPMovieSourceType.file
        moviePlayer.repeatMode = MPMovieRepeatMode.one
        self.moviePlayer.controlStyle = MPMovieControlStyle.embedded;
        moviePlayer.play()
        self.defaultView.addSubview(moviePlayer.view)
        self.defaultView.addSubview(btnPlayPause)
        btnPlayPause.isHidden = true
    }
    func Reload()
    {
        videoPlayer.readyToPlayVideo = {
            print("Video has been successfully loaded and can be played.")
        }
        videoPlayer.startedVideo = {
            print("Video has started playing.")
        }
        videoPlayer.playVideo()
    }
    @IBAction func btnFullScreenAction(_ sender: UIButton) {
        if isFull == false
        {
            isFull = true
           // objSuperView.frame = UIScreen.main.bounds
            moviePlayer.view.frame = UIScreen.main.bounds
            self.view.addSubview(moviePlayer.view)
            self.view.addSubview(btnPlayPause)
        }else{
            isFull = false
           // objSuperView.frame = ObjLastSize
            moviePlayer.view.frame = CGRect(x: 0.0, y: 0.0, width: objSuperView.frame.size.width , height: objSuperView.frame.size.height)
            self.objSuperView.addSubview(moviePlayer.view)
            self.objSuperView.addSubview(btnPlayPause)

        }
    }
    /*
    @IBAction func btnFullScreenAction(_ sender: UIButton) {
        if isFull == false
        {
            isFull = true
            objSuperView.frame = UIScreen.main.bounds
            videoPlayer.setNeedsLayout()
            videoPlayer.layoutIfNeeded()
            Reload()
            
        }else{
            isFull = false
            objSuperView.frame = ObjLastSize
            videoPlayer.setNeedsLayout()
            videoPlayer.layoutIfNeeded()
            Reload()
        }
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

