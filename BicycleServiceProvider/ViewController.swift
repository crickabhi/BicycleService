//
//  ViewController.swift
//  BicycleServiceProvider
//
//  Created by Abhinav Mathur on 29/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class ViewController: UIViewController , GMSMapViewDelegate {
    
    // MARK: - Private Declarations
    
    fileprivate var viewForMap          : GMSMapView!
    fileprivate var cameraPosition      : GMSCameraPosition!
    fileprivate var placesInformation   : JSON!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {

        if (AccessToken.sharedInstance.getAccessToken() == nil || (AccessToken.sharedInstance.getAccessToken()?.isEmpty)!) {
            DispatchQueue.main.async(execute: { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(viewController, animated: true, completion: nil)
            })
        }
        else{
            self.getPlacesDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraPosition = GMSCameraPosition.camera(withLatitude: 35.7090259,longitude:139.7319925, zoom:12)
        viewForMap = GMSMapView.map(withFrame: CGRect.zero, camera:cameraPosition)
        viewForMap.delegate = self
        
        self.view = viewForMap
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Google Maps Overrides
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        confirmationDialogue();
        return true
    }
    
    // MARK: - Private Functions
    
    fileprivate func confirmationDialogue() {
        let optionMenu = UIAlertController(title: nil, message: "Do you want to rent from this store?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Yes", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.performSegue(withIdentifier: "seguePayment", sender: nil)
        })
        let saveAction = UIAlertAction(title: "No", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    fileprivate func getPlacesDetails(){
        
        let endPoint: String = UrlConstants.serverHost + UrlConstants.rentPlacesUrl //"http://localhost:8080/api/v1/places"
        let headers = ["Authorization": AccessToken.sharedInstance.getAccessToken()!,"Accept": "application/json"]

        Alamofire.request(endPoint, headers: headers)
            .responseJSON { response in
                guard response.result.error == nil else {
                    UIAlertHandler.sharedInstance.showAlert(self, title: "", msg: (response.result.error?.localizedDescription)!)
                    return
                }
                if let value = response.result.value {
                    self.placesInformation = JSON(value)
                    self.setupPlaces();
                }
        }
    }
    
    fileprivate func setupPlaces(){
        for (_,subJson):(String, JSON) in placesInformation["results"] {
            
            
            let latitude = subJson["location"]["lat"].doubleValue
            let longitude = subJson["location"]["lng"].doubleValue
            let name = subJson["name"].stringValue
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake (latitude, longitude);
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.iconView = self.storeViewinfo(name)
            marker.title = name
            marker.map = viewForMap
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func tappedRefresh(_ sender: AnyObject) {
        self.getPlacesDetails();
    }
    
    // MARK: - Custom Controls
    
    func storeViewinfo(_ storeName: String) -> UIView {
        
        let storeInfoView = UIView(frame: CGRect(x: 100, y: 200,width: 70, height: 30))
        storeInfoView.backgroundColor=UIColor.green
        
        let title = UILabel(frame: CGRect(x: 0,y: 0,width: 70,height: 30))
        title.font = title.font.withSize(10)
        title.text = storeName
        
        storeInfoView.addSubview(title)
        return storeInfoView
    }
}
