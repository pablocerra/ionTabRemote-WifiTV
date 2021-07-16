//
//  credencialesObj.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
//  Object that collects all the necessary parameters to register in the api

import Foundation

class credentialsOBJ {
    
    let username : String
    let password : String
    let mac : String
    let url_api : String
    
    init() {
        
        let appConfig = UserDefaults.standard.dictionary(forKey: "com.apple.configuration.managed")
        username = appConfig?["username"] as? String ?? "es.ionide.ionTabRemote"
        password = appConfig?["password"] as? String ?? "ionide_david"
        mac = appConfig?["mac"] as? String ?? "ac-15-f4-3c-a5-f3"
        url_api = appConfig?["url_api"] as? String ?? "https://api-hlab.iontab.es"

    }
    
    
    
}
