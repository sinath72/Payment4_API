//
//  AppDelegate.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import UIKit

class AppDelegate: NSObject,UIApplicationDelegate {
    
    //set this variables with your service's on Payment4 Dashboarrd
    static var payment4 = Payment4(apiKey: "QAAJJQE2T3Z24NX5YC3KQCMPDNWA0OOU95Y5XVGI8CHL6MI1IU375G0UZXL2", callbackUrl: "https://taherkhani.shop/", webhoockUrl: "https://taherkhani.shop/wh")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
