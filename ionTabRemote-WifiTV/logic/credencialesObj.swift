//
//  credencialesObj.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
//  Objeto que recoge todos los parametros necesarios para registarse en la api

import Foundation

class credenciales {
    
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
