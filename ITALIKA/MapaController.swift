//
//  MapaController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var distribuidores = [Distribuidor]()
    var latitudes = [Double]()
    var longitudes = [Double]()
    var annotations = [MKPointAnnotation]()
    var locationManager = CLLocationManager()
    var noSurcursal = [Int]()
    
    override func viewDidLoad() {
        mapa.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapaController.disableTouch), name: "disebleTouchinMap", object: nil)
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapa.showsUserLocation = true
        configAnnotations()
    }
    
    override func viewDidAppear(animated: Bool) {
        var region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 19.3374322, longitude: -99.1385103), 15000, 15000)
        mapa.setRegion(region, animated: true)
        
    }
    
    
    func disableTouch() {
        mapa.userInteractionEnabled = false
    }
    
    func centerMapOnLocation(location: CLLocation, regionRadius:CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    
    func configAnnotations(){
        latitudes = [19.3384507,19.3883471,19.3873426,19.3741564,19.339856,19.3139221,19.3219175,19.2653743,19.2705229]
        longitudes = [-99.20568,-99.1884294,-99.1708353,-99.1162955,-99.113291,-99.1131569,-99.0850485,-99.1243757,-99.1572402]
        noSurcursal = [2787,2573,7520,2727,3047,2755,2815,7597,3687]
        
        for (var i = 0; i < latitudes.count;i++) {
            var d = Distribuidor(nombre: "Sucursal "+String(noSurcursal[i]), latitud: latitudes[i], longitud: longitudes[i], descripcion: "Horario: 9:00 am - 9:00 pm")
            distribuidores.append(d)
            
        }
        
        for (var i = 0; i < latitudes.count;i++) {
            annotations.append(MKPointAnnotation())
            annotations[i].coordinate = CLLocationCoordinate2D(latitude: latitudes[i], longitude: longitudes[i])
            annotations[i].title = distribuidores[i].nombre
            annotations[i].subtitle = distribuidores[i].descripcion
        }
        mapa.addAnnotations(annotations)
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        var annotationView = MKAnnotationView()
        annotationView.annotation = annotation
        var random = Int(arc4random_uniform(3) + 1)
        
        annotationView.image = UIImage(named: "Pin"+String(random))
        print(random)
        annotationView.canShowCallout = true
        annotationView.enabled = true
        
        let image = UIImage(named: "right") as UIImage?
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(0, 0, 30, 30)
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "goMaps:", forControlEvents:.TouchUpInside)
        
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView
        
    }

    
}
