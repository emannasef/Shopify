//
//  AppUserDefaults.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//
import Foundation
import UIKit
import Toast

func createToastMessage(message:String , view:UIView){
    
    var style = ToastStyle()
    style.messageColor = UIColor.clear
    style.backgroundColor = UIColor.white
    style.titleColor = UIColor.secondaryLabel
    style.messageColor = UIColor(named: "AccentColor 1")!
    style.maxWidthPercentage = 0.9
    view.makeToast(message, duration: 3.0, position: .bottom, style: style)
}

