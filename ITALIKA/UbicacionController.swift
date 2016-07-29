//
//  UbicacionController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit
import MapKit
import Social

class UbicacionController: UIViewController,MKMapViewDelegate,SWRevealViewControllerDelegate {
    
    
    @IBOutlet weak var btn_menu: UIButton!
    @IBOutlet weak var mapa: MKMapView!
    var distribuidores = [Distribuidor]()
    var latitudes = [Double]()
    var longitudes = [Double]()
    var annotations = [MKPointAnnotation]()
    var locationManager = CLLocationManager()
    var noSurcursal = [Int]()
    
    var origenAnnotation:MKAnnotation!
    
    var destino:MKAnnotation!
    
    override func viewDidLoad() {
        mapa.delegate = self
        self.revealViewController().delegate = self
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapa.showsUserLocation = true
        
        configAnnotations()
        btn_menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
        
        var longPressRecogniser = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        
        longPressRecogniser.minimumPressDuration = 1.0
        mapa.addGestureRecognizer(longPressRecogniser)
    }
    
    func handleLongPress(getstureRecognizer : UIGestureRecognizer){
        if getstureRecognizer.state != .Began { return }
        
        let touchPoint = getstureRecognizer.locationInView(self.mapa)
        let touchMapCoordinate = mapa.convertPoint(touchPoint, toCoordinateFromView: mapa)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        annotation.title = "Custom"
        destino = annotation
        mapa.addAnnotation(annotation)
    }
    
    override func viewDidAppear(animated: Bool) {
        var region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 19.3374322, longitude: -99.1385103), 15000, 15000)
        mapa.setRegion(region, animated: true)
        
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
    
    
    func centerMapOnLocation(location: CLLocation, regionRadius:CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        
        
        if let t = annotation.title  {
            if t == "Custom" {
                var annotationView = MKAnnotationView()
                annotationView.annotation = annotation
                annotationView.image = UIImage(named: "genericPin")
                annotationView.canShowCallout = false
                annotationView.enabled = true
                origenAnnotation = annotation
                return annotationView
            }
        }
        
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
        
        destino = annotation
        return annotationView
        
    }
    
    func goMaps(sender:AnyObject) {
        print("ir mapa")
        //let query = "?ll=\(latitudes[0]),\(longitudes[0])"
        let url = NSURL(string: "comgooglemaps://?daddr=19.30942,-99.1894017&directionsmode=driving")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func pedirAyuda(sender: UIButton) {
        let alert = UIAlertController(title: "¿Seguro quieres pedir ayuda?", message: nil, preferredStyle: .Alert)
        let siAction = UIAlertAction(title: "Continuar", style: .Default, handler: {algo in
            self.mostrarSolicitudDeAyuda()
        })
        let noAction = UIAlertAction(title: "Cancelar", style: .Destructive, handler: {algo in
        })
        
        alert.addAction(noAction)
        alert.addAction(siAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func mostrarSolicitudDeAyuda() {
        shareFacebookInBackground()
        let alert = UIAlertController(title: "Permanece en calma", message: "Se ha enviado un sms al 55-39291934. La ayuda va en camino!", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func shareFacebookInBackground(){
        var params : NSDictionary = NSDictionary()
        params = ["message" : "Prueba de App Italika: \nSufri un accidente, necesito tu ayuda."]
        let request : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/feed", parameters: params as [NSObject : AnyObject], HTTPMethod: "POST")
        request.startWithCompletionHandler({ (connection, result, error) -> Void in
            if error == nil{
                print(result)
            }else{
                print(error.localizedDescription)
            }
        })
        
    }
    
    
    func plotPolyline(route: MKRoute) {
        // 1
        mapa.addOverlay(route.polyline)
        // 2
        if mapa.overlays.count == 1 {
            mapa.setVisibleMapRect(route.polyline.boundingMapRect,
                                      edgePadding: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0),
                                      animated: false)
        }
            // 3
        else {
            let polylineBoundingRect =  MKMapRectUnion(mapa.visibleMapRect,
                                                       route.polyline.boundingMapRect)
            mapa.setVisibleMapRect(polylineBoundingRect,
                                      edgePadding: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0),
                                      animated: false)
        }
    }
    
    
    func mapView(mapView: MKMapView,
                 rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        if (overlay is MKPolyline) {
            if mapView.overlays.count == 1 {
                polylineRenderer.strokeColor =
                    UIColor.blueColor().colorWithAlphaComponent(0.75)
            } else if mapView.overlays.count == 2 {
                polylineRenderer.strokeColor =
                    UIColor.greenColor().colorWithAlphaComponent(0.75)
            } else if mapView.overlays.count == 3 {
                polylineRenderer.strokeColor =
                    UIColor.redColor().colorWithAlphaComponent(0.75)
            }
            polylineRenderer.lineWidth = 5
        }
        return polylineRenderer
    }

    /*func calculateSegmentDirections(index: Int) {
        // 1
        let request: MKDirectionsRequest = MKDirectionsRequest()
        request.source = origenAnnotation.
        request.destination =
        // 2
        request.requestsAlternateRoutes = true
        // 3
        request.transportType = .Automobile
        // 4
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler ({
            (response: MKDirectionsResponse?, error: NSError?) in
            if let routeResponse = response?.routes {
                
            } else if let _ = error {
                
            }
        })
    }*/

    
    
}
