//
//  Payment4_APIApp.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import SwiftUI

@main
struct Payment4_APIApp: App {
    // injection of AppDelegate to App for using public variables and method and function of inside AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
