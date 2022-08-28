//
//  UserDetails_VC.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import UIKit
import MapKit

class UserDetails_VC: UIViewController {
    
    @IBOutlet var vw_detailsbk : UIView!
    @IBOutlet var vw_mapbk: UIView!
    @IBOutlet var img_Profile: UIImageView!
    @IBOutlet var mkMap: MKMapView!
    @IBOutlet var lbl_Name: UILabel!
    @IBOutlet var lbl_Email: UILabel!
    @IBOutlet var lbl_address: UILabel!
    @IBOutlet var lbl_Phone: UILabel!
    @IBOutlet var lbl_Website: UILabel!
    @IBOutlet var lbl_Company: UILabel!
    
    
    
    
    var strName: String?
    var strEmail: String?
    var strAddress: String?
    var strphone: String?
    var strWebsite: String?
    var strCompany: String?
    var lat: String?
    var lng: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        vw_detailsbk.setborderView()
        vw_mapbk.setborderView()
        img_Profile.makeRounded()
        // Set shadow and cornet couner in UIView
        vw_detailsbk.dropShadow(color: .gray, opacity: 0.4, offSet: CGSize.init(width: 5, height: 5), radius: 100, scale: true)
        vw_detailsbk.layer.cornerRadius = 15
        vw_mapbk.dropShadow(color: .gray, opacity: 0.4, offSet: CGSize.init(width: 5, height: 5), radius: 100, scale: true)
        vw_mapbk.layer.cornerRadius = 15
        setData()
    }
    //MARK: Mapping data to controls
    func setData() {
        lbl_Name.text = strName
        lbl_Email.text = strEmail
        lbl_address.text = strAddress
        lbl_Phone.text = strphone
        lbl_Website.text = strWebsite
        lbl_Company.text = strCompany
        
        //MARK: Implement intial code for MKMap and set user pin.
        mkMap.mapType = MKMapType.standard
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(lat ?? "0.00") ?? 0.00), longitude: CLLocationDegrees(Double(lng ?? "0.00") ?? 0.00))
        let region = MKCoordinateRegion( center: location, latitudinalMeters: CLLocationDistance(exactly: 4000)!, longitudinalMeters: CLLocationDistance(exactly: 4000)!)
        mkMap.setRegion(mkMap.regionThatFits(region), animated: true)

       let annotation = MKPointAnnotation()
       annotation.coordinate = location
       annotation.title = strName
       annotation.subtitle = strAddress
       mkMap.addAnnotation(annotation)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
