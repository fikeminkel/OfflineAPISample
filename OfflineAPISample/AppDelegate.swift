//
//  AppDelegate.swift
//  OfflineAPISample
//
//  Created by Mike Finkel on 8/29/18.
//  Copyright © 2018 Mike Finkel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var offlineDataProvider: OfflineDataProvider?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        setenv("CFNETWORK_DIAGNOSTICS", "3", 1);
        setupDataProviders()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }


}

// MARK: setup functions
extension AppDelegate {
    var isOffline: Bool {
        #if OFFLINE
            return true
        #else
            return false
        #endif
    }
    private func setupDataProviders() {
        if isOffline {
            offlineDataProvider = OfflineDataProvider()
        }
    }
}
