//
//  AppDelegate.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 7/7/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var configtv = configTV()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        antes de inicar la app creo el objeto con las credenciales, creo el token y hago las peticiones necesarias para conseguir los parametros
        
//        let credenciales = credenciales()
//        let token = token()
//        token.credencialesO=credenciales
//        
//        let resultadoPeticionPost = communicationsServer.postLogin(username: credenciales.username, password: credenciales.password, mac: credenciales.mac, bundleId: "es.ionide.WifiTV", version: "0.0.1", url: credenciales.url_api, tokenO: token)
//        
//        if resultadoPeticionPost {
//            //        var confitv:configTV = communicationsServer.get(operation: "/config/remote_wifitv", token: token)
//        }
        
        
        return true
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

