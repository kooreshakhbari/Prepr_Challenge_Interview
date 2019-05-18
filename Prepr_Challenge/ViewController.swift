//
//  ViewController.swift
//  Prepr_Challenge
//
//  Created by Kooresh Akhbari on 2019-05-18.
//  Copyright © 2019 Kooresh Akhbari. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {


    
    @IBOutlet weak var select_bttn: UIButton!
    @IBOutlet weak var web: UIButton!
    @IBOutlet var city_bttn: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Initally when app loads up zoom onto the first company in chinal
        let camera = GMSCameraPosition.camera(withLatitude: 31.224671, longitude: 121.480206, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
       
        view = mapView
        
  
        
        //Initally when app loads up if user doesnt choose a country just drop all the pins and when
        //you click on pin you will get address and title of that location
        
        //All the variables have been imported from the excel file
        for i in 0..<lats.count{
            //Get corresponding Lat Lon of location
            let lat = lats[i]
            let lon = lons[i]
            
            //get Title and address of location
            let title = titles[i]
            let addr = address[i]
            
            //Create a marker and set its parameters
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            marker.title = title
            marker.snippet = addr
            marker.map = mapView
           
        }
        
        //Allow scrolling and zoom gestures for user to move around
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        
        self.view = mapView
        self.view.addSubview(select_bttn)
        self.view.addSubview(web)
        
        city_bttn.forEach{(button) in
            self.view.addSubview(button)
        }
        

  
    }
    //When the select a city button is pressed
    //Reveal the cities
    @IBAction func hand_selection(_ sender: UIButton) {
        city_bttn.forEach{(button) in
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden = !button.isHidden
            })
            
        }
        
    }
    
    //When a city is tapped, hide the cities
    //Zoom onto the city and show pins
    @IBAction func city_tapped(_ sender: UIButton) {
        city_bttn.forEach{(button) in
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden = !button.isHidden
            })
            
        }
        
         let city_tag = sender.tag
         print(city_tag)
        
        //If tag is 0 city is Shanghai
        //2 Tbilisi
        //Ahmedabad
        
        if(city_tag == 0){
            city_selector(start: 0, end: 13)
            
            
        }
        else if (city_tag == 1){
            
            city_selector(start: 14, end: 18)
            
            
            
        }
        else{
            city_selector(start: 19, end: 29)
            
    }
}
    
    //Listener to open Prepr.org when user clicks on company icon
    @IBAction func web_button(_ sender: UIButton) {
        guard let url = URL(string: "https://prepr.org/") else { return }
        UIApplication.shared.open(url)
    }
    
    
    

    
//Function to draw pins when a city is selected
func city_selector(start: Int, end: Int){

    //Initally when app loads up zoom onto the first company in chinal
    let camera = GMSCameraPosition.camera(withLatitude: lats[start], longitude: lons[start], zoom: 13.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    
    view = mapView
    
    for i in start...end{
        //Get corresponding Lat Lon of location
        let lat = lats[i]
        let lon = lons[i]
        
        //get Title and address of location
        let title = titles[i]
        let addr = address[i]
        
        //Create a marker and set its parameters
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.title = title
        marker.snippet = addr
        marker.map = mapView
        
    }
    self.view = mapView
    self.view.addSubview(select_bttn)
    self.view.addSubview(web)
    
    city_bttn.forEach{(button) in
        self.view.addSubview(button)
        }
    
    }
    
}

