//
//  AppDelegate.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import UIKit

class AppDelegate: NSObject,UIApplicationDelegate {
    
    //set this variables with your service's on Payment4 Dashboarrd
    static var payment4 = Payment4(apiKey: "", callbackUrl: "", webhoockUrl: "")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
