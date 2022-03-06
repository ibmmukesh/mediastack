//
//  AppDelegate.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import UIKit

typealias completionHandler = ()->()
typealias onErrorHandler = ()->()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        saveTokenToKeyChain() //Save access Token to Keychain
        return true
    }

    private func saveTokenToKeyChain(){
        // Create an object to save
        let accessToken = AppConstant.API.apiAccessKey
        let account = AppConstant.secAttribAccount
        let service = AppConstant.secAttribServiceKey
        // Save `auth` to keychain
        KeychainHelper.standard.save(accessToken, service: service, account: account)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
