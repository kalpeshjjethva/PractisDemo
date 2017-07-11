//
//  GoogleMapView.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 11/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapView: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var MyView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var objMapview: GMSMapView!
    
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    @IBOutlet weak var lblCounter: UILabel!
    private var infoWindow = CustomCalloutView()
    @IBOutlet weak var markertIcon: UIView!
    var counter = NSInteger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markertIcon.isHidden = true
        
//AIzaSyDRI-n4Lgc3pfQ2fEem8FZeC_txgGkcQN8
//AIzaSyCwY83-RT00Ji5G39LQfjh0vpGoSCt5RE8
        
        objMapview.delegate = self

        
        for i in 0...3
        {
            let myview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
            myview.layer.cornerRadius = 20
            myview.layer.masksToBounds = true
            myview.backgroundColor = UIColor.red
            let lablt = UILabel(frame: CGRect(x: 0.0, y: 10.0, width: 40.0, height: 20.0))
            lablt.textAlignment = .center
            
            if i == 0
            {
                let marker = GMSMarker()
                let camera = GMSCameraPosition.camera(withLatitude: -33.908,
                                                      longitude: 151.2086,
                                                      zoom: 0)
                marker.position = camera.target
                marker.iconView = myview
                marker.map = objMapview
                lablt.text = String(50)

            }else if i == 1 {
                
                let marker = GMSMarker()
                let camera = GMSCameraPosition.camera(withLatitude: 25.3548,
                                                      longitude: 51.1839,
                                                      zoom: 0)
                marker.position = camera.target
                marker.iconView = myview
                marker.map = objMapview
                lablt.text = String(51)

            }else{
                
                let marker = GMSMarker()
                let camera = GMSCameraPosition.camera(withLatitude: 22.1408,
                                                      longitude: 72.45682,
                                                      zoom: 0)
                objMapview.camera = camera
                marker.position = camera.target
                marker.iconView = myview
                marker.map = objMapview
                lablt.text = String(52)
            }
            myview.addSubview(lablt)
        }
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                objMapview.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("The style definition could not be loaded: \(error)")
        }
        infoWindow = loadNiB()

    }
    func loadNiB() -> CustomCalloutView{
        let infoWindow = CustomCalloutView.instanceFromNib() as! CustomCalloutView
        infoWindow.clipsToBounds = true
        if counter == 0
        {
            infoWindow.objString = "kalpesh 0"
            counter += 1
            
        }else if counter == 1{
            
            infoWindow.objString = "kalpesh 1"
            counter += 1
            
        }else{
            
            infoWindow.objString = "kalpesh 2"
            counter += 1
        }
        infoWindow.tblView.reloadData()
        return infoWindow
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "kalpesh"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("self. didselect")
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        // Needed to create the custom info window
        locationMarker = marker
        infoWindow.removeFromSuperview()
        infoWindow = loadNiB()
        guard let location = locationMarker?.position else {
            print("locationMarker is nil")
            return false
        }
        MyView.center = mapView.projection.point(for: location)
        MyView.center.y = MyView.center.y - MyView.frame.size.height  + 50 // - sizeForOffset(view: infoWindow) - 200

//        infoWindow.center.y = infoWindow.center.y - 200 // - sizeForOffset(view: infoWindow) - 200
        
        self.objMapview.addSubview(MyView)
        
        return false
    }
    func sizeForOffset(view: UIView) -> CGFloat {
        return  135.0
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            let location = locationMarker?.position
            MyView.center = mapView.projection.point(for: location!)
            MyView.center.y = MyView.center.y - MyView.frame.size.height + 50 // - sizeForOffset(view: infoWindow) - 200
        }
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }
   /* func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("CustomCalloutView", owner: self, options: nil)?.first! as! CustomCalloutView
        // infoWindow.updateView(name: marker.title!, details: marker.snippet!, location: "\(marker.position.latitude), \(marker.position.longitude)")
        infoWindow.objString = "Custom call out"
        infoWindow.tblView.reloadData()
        let view = UIView(frame: infoWindow.frame)
        view.addSubview(infoWindow)
        return view
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}
