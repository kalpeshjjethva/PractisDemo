//
//  DrawRout.swift
//  PractisDemo
//sdf
//  Created by Mehul Solanki on 07/06/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import MapKit

class DrawRout: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var objMapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        objMapview.delegate = self
        makeGetCall()
        
    }
    
    @IBAction func btnaddLoaderAction(_ sender: UIButton) {
        
        let objAppDelegate = UIApplication.shared.delegate as! AppDelegate
        objAppDelegate.LoaderView.frame = UIScreen.main.bounds
        objAppDelegate.LoaderView.backgroundColor = UIColor.black
        
        objAppDelegate.actLoader.startAnimating()
        objAppDelegate.lblLoaderText.text = "Loading..."
        self.view.addSubview(objAppDelegate.LoaderView)
        
        let when = DispatchTime.now() + 10 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            let objAppDelegate = UIApplication.shared.delegate as! AppDelegate
            objAppDelegate.LoaderView.removeFromSuperview()
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let routeLineRenderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        routeLineRenderer.strokeColor = UIColor.red
        routeLineRenderer.lineWidth = 5
        zoom(toPolyLine: mapView, polyline: overlay as! MKPolyline, animated: true)
        return routeLineRenderer
    }
    func zoom(toPolyLine map: MKMapView, polyline: MKPolyline, animated: Bool) {
        map.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0), animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func makeGetCall() {
        let origin: String = "26.4686138,78.3836359"
        let drivein: String = "23.0472963,72.52757040000006"
        let apikey: String = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(drivein)"
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(23.0472963), longitude: Double(72.52757040000006)), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.objMapview.setRegion(region, animated: true)

        
        let url = URL(string: apikey)!
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                    {
                        //Implement your logic
                       // print("json>>", json)
                        let routesArray: [Any]? = (json["routes"] as? [Any])
                       // print("route array \(routesArray)")
                        if (routesArray?.count)! > 0 {
                            let routeDict: [AnyHashable: Any]? = (routesArray?[0] as? [AnyHashable: Any])
                            let routeOverviewPolyline: [AnyHashable: Any]? = (routeDict?["overview_polyline"] as? [AnyHashable: Any])
                            let points: String? = (routeOverviewPolyline?["points"] as! String)
                            
                           // print("points>>", points!)
                            
                            let polyline = Polyline(encodedPolyline: points!)
                            let decodedCoordinates = polyline.coordinates!
                           // print("decodedCoordinates>>", decodedCoordinates)
                            
                            DispatchQueue.main.async {
                                let polylineeee = MKPolyline(coordinates: decodedCoordinates, count: decodedCoordinates.count)
                                self.objMapview.add(polylineeee)
                            }
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
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
