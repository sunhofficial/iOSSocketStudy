//
//  AppDelegate.swift
//  SocketStudy
//
//  Created by 235 on 2023/06/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    //app이 active할때마다 서버와 연결하고
    func applicationDidBecomeActive(_ application: UIApplication) {
              SocketViewModel.shared.establishConnection()
      }
    // app이 background로 갈때마다 서버 종료
      func applicationDidEnterBackground(_ application: UIApplication) {
              SocketViewModel.shared.closeConnection()
      }


}

