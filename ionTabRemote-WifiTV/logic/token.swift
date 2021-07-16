//
//  token.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
// object in charge of collecting the tokens that are generated when registering in the api

import Foundation

class token {
    
    var credencialesO: credentialsOBJ = credentialsOBJ()
    var refresh_token : String
    var token : String
    
    
    init(refresh_token : String, token : String, credencialesO: credentialsOBJ) {
        self.refresh_token  = refresh_token
        self.token = token
        self.credencialesO = credencialesO
    }
    
    init() {
        self.refresh_token  = ""
        self.token = ""
        
    }
    

    
}
    
