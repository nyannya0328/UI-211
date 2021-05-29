//
//  MapView.swift
//  UI-211
//
//  Created by にゃんにゃん丸 on 2021/05/29.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var model : MapViewModel
    
    func makeCoordinator() -> Coordinator {
        

        return MapView.Coordinator()
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = model.mapView
        
        view.showsUserLocation = true
        
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject,MKMapViewDelegate{
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self){return nil}
            
            else{
                
                
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_ANNOTATION")
                
                pinAnnotation.animatesDrop = true
                pinAnnotation.pinTintColor = .red
                pinAnnotation.canShowCallout = true
                
                return pinAnnotation
                
            }
            
            
        }
        
        
        
        
    }
    
    
}


