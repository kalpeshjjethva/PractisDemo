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
        
        /*
        ObjLastSize = objSuperView.frame
        let videoURL = URL(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
        videoPlayer.videoURL = videoURL
        videoPlayer.readyToPlayVideo = {
            print("Video has been successfully loaded and can be played.")
        }
        videoPlayer.startedVideo = {
            print("Video has started playing.")			
        }
        videoPlayer.playVideo()
        */
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

