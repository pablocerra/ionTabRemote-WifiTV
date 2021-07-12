//
//  token.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
// objeto encargado de recoger los token que se generan al registrarse en la api

import Foundation

class token {
    
    var credencialesO: credenciales = credenciales()
    var refresh_token : String
    var token : String
    
    
    init(refresh_token : String, token : String, credencialesO: credenciales) {
        self.refresh_token  = refresh_token
        self.token = token
        self.credencialesO = credencialesO
    }
    
    init() {
        self.refresh_token  = ""
        self.token = ""
        
    }
    
//    se encarga de renovar el token en el momento en el que se necesite hacerlo.
    
    func renove() -> Bool {
        
        let renoveToken:String =  communicationsServer.postRefresh(username: credencialesO.username, password: credencialesO.password, mac: credencialesO.mac, bundleId: "es.ionide.WifiTV", version: "1", url: "es.ionide.WifiTV", tokenR: refresh_token)
        
        token = renoveToken
        
        return true
    }
    
}
    
