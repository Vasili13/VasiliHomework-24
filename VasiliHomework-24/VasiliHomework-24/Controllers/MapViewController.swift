//
//  MapViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 27.12.22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var user: User?
    private let locationManager = CLLocationManager()
    private let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last
            let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

            self.mapView.setRegion(region, animated: true)
            self.locationManager.stopUpdatingLocation()

        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Errors " + error.localizedDescription)
        }

}
