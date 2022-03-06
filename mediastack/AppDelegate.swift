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
    
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        saveTokenToKeyChain() //Save access Token to Keychain
        
        if #available(iOS 13, *) {
            return true
        }else{
            setRootController()
        }
        return true
    }
    
    private func setRootController(){
        
        // create the main navigation controller to be used for our app
        let navController = UINavigationController()
        // send that into our coordinator so that it can display view controllers
        coordinator = MainCoordinator(navigationController: navController)
        // tell the coordinator to take over control
        coordinator?.showNews()
        // create a basic UIWindow and activate it
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
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
