//
//  Global.swift
//  Karoooo Test
//
//  Created by Sevenbits on 28/08/22.
//

import Foundation
import UIKit

// MARK: - Global access alert
func showAlert(_ view: UIViewController, message: String) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        
    }))
    view.present(alert, animated: true, completion: nil)
}
