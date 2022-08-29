//
//  AppDelegate.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import UIKit
import CoreLocation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var mlocationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.distanceFilter = kCLLocationAccuracyBest
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    var db:DBHelper = DBHelper()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        mlocationManager.delegate = self
        db.insert(email: "johnsmith@gmail.com", password: "123456", phone: "+17043456562")
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//MARK:- Location Manager Delegate
extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count != 0 else { return }
        guard let lastLocation = locations.last else { return }
        if lastLocation.coordinate.latitude != 0 {
            CLGeocoder().reverseGeocodeLocation(lastLocation) { [weak self] placemarks, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    // get error, and stop action
                    strongSelf.mlocationManager.stopUpdatingLocation()
                    print("ERROR :\(error.localizedDescription)")
                    return
                }
                guard let placemarks = placemarks, placemarks.count > 0 else { return }
                guard let countryCode  = placemarks.first?.isoCountryCode else { return }
                guard let locality = placemarks.first?.locality else { return }
                Helper.fetchDataFromBundle { [weak self] result in
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let responseModel):
                        for (_, element) in responseModel.enumerated() {
                            if countryCode == element.code {
                                let filePath = Helper.getAssetsBundlePath(with: "Images",
                                                                          fileName: element.code,
                                                                          fileExtension: ".png")
                                let countryDetail = CountriesResponseModelElement(name: element.name,
                                                                                  dialCode: element.dialCode,
                                                                                  code: element.code,
                                                                                  locality: locality,
                                                                                  filePath: filePath)
                                strongSelf.mlocationManager.stopUpdatingLocation()
                                NotificationCenter.default.post(name: .didFetchLocationNotification, object: countryDetail)
                                return
                            }
                        }
                    case .failure(let error):
                        print("ERROR:", error.localizedDescription)
                        strongSelf.mlocationManager.stopUpdatingLocation()
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
