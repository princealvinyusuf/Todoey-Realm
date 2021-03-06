//
//  AppDelegate.swift
//  Destini
//
//  Created by Prince Alvin Yusuf on 04/03/2021.
//  Copyright (c) 2021 Prince Alvin Yusuf. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing new realm \(error.localizedDescription)")
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    

}

