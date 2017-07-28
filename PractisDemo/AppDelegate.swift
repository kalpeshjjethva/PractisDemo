//
//  AppDelegate.swift
//  PractisDemo
//
//  Created by sdfMehul Solanki on 29/05/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import GoogleMaps
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    @IBOutlet weak var actLoader: UIActivityIndicatorView!
    @IBOutlet weak var lblLoaderText: UILabel!
    @IBOutlet var LoaderView: UIView!
    @IBOutlet weak var subLoaderView: UIView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
            Fabric.with([Crashlytics.self])
        
        GMSServices.provideAPIKey("AIzaSyCwY83-RT00Ji5G39LQfjh0vpGoSCt5RE8")
        GMSPlacesClient.provideAPIKey("AIzaSyCwY83-RT00Ji5G39LQfjh0vpGoSCt5RE8")
        
        

            logUser()
           // self.LoaderView = Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)?.first as! UIView
        
        self.LoaderView = Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)?.first as! UIView

        // Override point for customization after application launch.
        return true
    }
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("kalpesh.jethva@sufalamtech.com")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

/*
 https://github.com/vsouza/awesome-ios
 
 https://github.com/kevinzhow/PNChart
 
 https://github.com/JunyiXie/XJYChart
 
 
 
 IOS chart class
 
 http://cocoadocs.org/docsets/Charts/2.0.9/Classes.html#/s:C6Charts12PieChartData
 
 
 
 High Charts
 
 https://github.com/highcharts/highcharts-ios
 
https://github.com/rajagp/iOS_Highcharts_Sample
 
https://jsfiddle.net/gh/get/jquery/1.11.0/highslide-software/highcharts.com/tree/master/samples/highcharts/exporting/offline-download/

http://www.knowstack.com/different-ways-of-loading-highcharts-data/
 
 */
