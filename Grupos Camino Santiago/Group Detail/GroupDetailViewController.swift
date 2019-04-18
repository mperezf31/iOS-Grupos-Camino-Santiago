//
//  GroupDetailViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import MapKit
import MaterialComponents.MaterialSnackbar
import JGProgressHUD

class GroupDetailViewController: UIViewController ,  MKMapViewDelegate, GroupDetailViewModelDelegate{
   
    @IBOutlet weak var groupPhoto: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var departurePlace: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var founderPhoto: UIImageView!
    @IBOutlet weak var founderName: UILabel!
    @IBOutlet weak var founderEmail: UILabel!
    
    private let viewModel: GroupDetailViewModel
    private let hud = JGProgressHUD(style: .dark)
    
    init(viewModel: GroupDetailViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupDetailViewModel(groupId: 0, groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.tabBarController?.title = "Detalle"

        self.viewModel.getGroupDetail()
    }
    
    
    func groupDetailRetrieved(_: GroupDetailViewModel, group: GroupViewModel) {
        self.groupPhoto.image = group.photo
        self.groupTitle.text = group.title
        self.tabBarController?.title = group.title
        self.departureDate.text = "Salida:  \(group.departureDate)"
        self.arrivalDate.text = "Llegada: \(group.arrivalDate)"
        self.groupDescription.text = group.description
        self.departurePlace.text = group.departurePlace
        
        let groupPin = group.groupPin
        self.mapView.addAnnotations([groupPin])
        let region = MKCoordinateRegion(center: groupPin.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        self.mapView.setRegion(region, animated: true)
        
        self.founderPhoto.image = group.founderPhoto
        self.founderName.text = group.founderName
        self.founderEmail.text = group.founderEmail
    }
    
    func showIndicator(_: GroupDetailViewModel, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    func hideIndicator(_: GroupDetailViewModel) {
        hud.dismiss()
    }
    
    func error(_: GroupDetailViewModel, errorMsg: String) {
        let message = MDCSnackbarMessage()
        message.text = errorMsg
        MDCSnackbarManager.show(message)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let identifier = "Group"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }else{
            annotationView!.annotation = annotation
        }
        
        annotationView!.canShowCallout = true
        
        let annotationPin = annotation as! GroupPin
        
        let imageView = UIImageView(image: annotationPin.image )
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        annotationView!.leftCalloutAccessoryView = imageView
        
        return annotationView!
    }
    
}
