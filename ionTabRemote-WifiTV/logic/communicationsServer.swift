//
//  communicationsServer.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
//

import Foundation


class communicationsServer {
    
//    metodo encargado de conseguir los parametros de la tv, devuelve la configuracion de la tv
    
    static func get(url:String,
                    token: String){
        
        struct dicConfig: Codable {
            var ble_name: String
            var ble_token: String
        }
        
        guard let urllet = URL(string: (url)) else { return }


        var request = URLRequest(url: urllet)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {

                    let json = try JSONDecoder().decode(dicConfig.self, from: data)
                                       
//                    configuracionTV.ble_name = json.ble_name
//                    configuracionTV.ble_token = json.ble_token
                    
                    configuracionTV.ble_name = "WIFITV1234"
                    configuracionTV.ble_token = "12345678"
                    
                } catch {
                    print(error)
                }
                
            }
        }.resume()
  
    }
    
//    Static function in charge of generating the login token, the necessary parameters are passed to it for the regustri, or. I will return true or false, denouncing whatever the result of the execution is.
    
    static func post(username : String,
                     password : String,
                     mac : String,
                     bundleId : String,
                     version : String,
                     url: String,
                     tokenRenew: String ){
       
        struct dicToken: Codable {
            var refresh_token: String
            var token: String
        }
        
        var parameters = ["":""]
        
        if tokenRenew != "" {
            
            parameters = ["username": username, "password" : password, "mac" : mac, "bundleId" : bundleId, "version" : version, "token": tokenRenew]
        
        }else{
            
            parameters = ["username": username, "password" : password, "mac" : mac, "bundleId" : bundleId, "version" : version]
            
        }
        
       
     
        guard let urllet = URL(string: (url)) else { return }
        var request = URLRequest(url: urllet)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                    
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                
                                
                return
                }
            
            do {
                
                let json = try JSONDecoder().decode(dicToken.self, from: data)

                get(url: "https://api-hlab.iontab.es/config/remote_wifitv" , token: json.token)
                    
                print(json)
                
            } catch {
                    print(error)
                }
            
            
                   

            }.resume()


    }
    
//
    
    static func petition(petition:String,
                         credenciales: credentialsOBJ ) {
        
        switch petition {
            case "login":
                
                post(username: credenciales.username, password: credenciales.password, mac: credenciales.mac, bundleId: "es.ionide.WifiTV", version: "0.0.1", url: (credenciales.url_api + "/login"), tokenRenew: "")
                        
            case "renoveLogin":
                
                post(username: credenciales.username, password: credenciales.password, mac: credenciales.mac, bundleId: "es.ionide.WifiTV", version: "0.0.1", url: (credenciales.url_api + "/config/remote_wifitv"), tokenRenew: "")
                
            case "get":
                
                get(url: "https://api-hlab.iontab.es/config/remote_wifitv", token: "")
                
            default:
                print("error")
        }
    }
    
    
    
    
}
