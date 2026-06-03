//
//  MapViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Select Location"
        let doneNavigationButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneNavigationClicked))
        navigationItem.rightBarButtonItem = doneNavigationButton
        
        mapView.delegate = self
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            self.mapView.removeAnnotations(self.mapView.annotations)
            //print("begen")
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let touchCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            let selectedLocation = CLLocation(latitude: touchCoordinates.latitude, longitude: touchCoordinates.longitude)
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(selectedLocation) { placemarks, error in
                //let subThroughFare = placemarks?.first?.subThoroughfare,
                if let addressName = placemarks?.first?.thoroughfare,
                    let cityName = placemarks?.first?.locality,
                    let countryName = placemarks?.first?.country
                {
                    //  print("Adress :\(subThroughFare) - City  \(thoroughFare), Loca \(locality), count \(country)")
                    //print("\(countryName), \(cityName), \(addressName)")
                    NotificationCenter.default.post(name: NSNotification.Name("selectedAdress"), object: nil, userInfo: ["selectedAdress": "\(countryName), \(cityName), \(addressName)"])
                }
            }
            
            let pin = MKPointAnnotation()
            pin.coordinate = touchCoordinates
            mapView.addAnnotation(pin)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            renderLocation(location: location)
        }
    }
    
    func renderLocation (location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func doneNavigationClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
