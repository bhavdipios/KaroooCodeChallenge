//
//  Extensions.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import UIKit
import WebKit

extension UIImageView {
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

extension UIView {
    func setborderView() {
        self.layer.borderWidth = 0.6;
        self.layer.borderColor =  UIColor.lightGray.cgColor
        self.layer.cornerRadius = 15
    }
}
extension UIButton {
    func setborderButton() {
        self.layer.borderWidth = 0.6;
        self.layer.borderColor =  UIColor.lightGray.cgColor
        self.layer.cornerRadius = 15
    }
}
extension UITextField {
    
    func setborder() {
        self.layer.borderWidth = 0.6;
        self.layer.borderColor =  UIColor.lightGray.cgColor
        self.layer.cornerRadius = 15
    }
    
    func setLeftImage(imageName:String) {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView;
        self.leftViewMode = .always
        
        
    }
    func setLeftPaddingPoints(_ amount:CGFloat, imgname: String){
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
          let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
            imageView.image = UIImage(named: imgname)
            paddingView.addSubview(imageView)
           self.leftView = paddingView
           self.leftViewMode = .always
       }
   func setRightPaddingPoints(_ amount:CGFloat) {
       let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
       self.rightView = paddingView
       self.rightViewMode = .always
   }
}
