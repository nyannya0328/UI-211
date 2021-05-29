//
//  MapViewModel.swift
//  UI-211
//
//  Created by にゃんにゃん丸 on 2021/05/29.
//

import SwiftUI
import MapKit

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    @Published var region : MKCoordinateRegion!
    
    @Published var permissionDeneid = false
    
    
    @Published var mapType : MKMapType = .standard
    
    @Published var txt = ""
    
    @Published var places : [Place] = []
    
    
    func selecetPlace(place : Place){
        
        txt = ""
        
        guard let coordinate = place.placeMark.location?.coordinate else{return}
        
        let pinAnnotaiton = MKPointAnnotation()
        
        pinAnnotaiton.coordinate = coordinate
        
        pinAnnotaiton.title = place.placeMark.name ?? "No Place"
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pinAnnotaiton)
        
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        
        
        
        
    }
    
    
    func searchQuery(){
        places.removeAll()
        
        let requset = MKLocalSearch.Request()
        
        requset.naturalLanguageQuery = txt
        
        
        
        MKLocalSearch(request: requset).start { respoce, _ in
            guard let result = respoce else {return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                
                return Place(placeMark: item.placemark)
                
                
            })
            
        }
        
        
        
        
    }
    
    
    func changeType(){
        
        if mapType == .standard{
            
            mapType = .hybrid
            mapView.mapType = mapType
            
            
        }
        
        else if mapType == .hybrid{
            
            mapType = .satellite
            mapView.mapType = mapType
            
            
        }
        
        else{
            
            mapType = .standard
            mapView.mapType = mapType
        }
        
        
        
    }
    
    
    func foucusRegion(){
        
        guard let _ = region else{return}
        
        
        mapView.setRegion(region, animated: true)
        
        mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        
    }
    
    
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .denied:
            
            permissionDeneid.toggle()
            
        case .notDetermined :
            
            manager.requestWhenInUseAuthorization()
            
        case.authorizedWhenInUse:
            
            manager.requestLocation()
            
        default:
            ()
        }
        
    }
   
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        
        
    
        
    }
    
}


