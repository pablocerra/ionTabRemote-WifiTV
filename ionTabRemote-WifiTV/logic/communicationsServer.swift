//
//  communicationsServer.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
//

import Foundation


class communicationsServer {
    
//    metodo encargado de conseguir los parametros de la tv, devuelve la configuracion de la tv
    
    static func get(operation:String, token: token) -> configTV {
        
        let tvConfig = configTV()
        
//        Se crea un semaforo para realizar la sicronizaccion del codigo.
        
        let sem = DispatchSemaphore(value: 0)
        
        struct dicConfig: Codable {
            var ble_name: String
            var ble_token: String
        }
        
//        genero la url de la peticion
        
        guard let url = URL(string: ("https://api-hlab.iontab.es" + operation )) else { return tvConfig }
        
        let token1 = token.token
        
//        creo los paramtros de la ul, asigandole el token de resgistro.
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token1)", forHTTPHeaderField: "Authorization")
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

//                    recojo los datos que devuelve la peticion, y desbloqueo el semaforo.
                    
                    let json = try JSONDecoder().decode(dicConfig.self, from: data)
                    
                    tvConfig.ble_name = json.ble_name
                    tvConfig.ble_token = json.ble_token
                    sem.signal()
                    
                    
                    print(json)
                } catch {
                    print(error)
                }
                
            }
        }.resume()
        
//        bloqueo el semaforo
        
        sem.wait()
        
        return tvConfig
    }
    
//    Funcion estatica encargada de general el token de login, se le pasan los parametros necesarios para el regustri, o. Delvuelvo verdadero o falso demendiendo de cual sea el resultado de la ejecucion.
    
    static func postLogin(username : String, password : String, mac : String, bundleId : String, version : String, url: String, tokenO: token ) -> Bool {

//        Se crea un semaforo para realizar la sicronizaccion del codigo.
        
        let sem = DispatchSemaphore(value: 0)
        
//        creo un diccionario para regoer los valores que devuelve la peticion,
        
        var resultado = false
        
        struct dicToken: Codable {
            var refresh_token: String
            var token: String
        }
//      establezco los parametros del body
        
        let parameters = ["username": username, "password" : password, "mac" : mac, "bundleId" : bundleId, "version" : version]
               
//        genero la url, digo el metodo que voy a usar y añado el body.
        
        guard let urllet = URL(string: (url + "/login" )) else { return resultado }
        var request = URLRequest(url: urllet)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return resultado }
        request.httpBody = httpBody
               
//        realizo la peticion
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
                   
            if let data = data {
                do {
                    
// guardo el resultado en el diccionario, reasigno los valores, y desbloqueo el semaforo.
                    
                let json = try JSONDecoder().decode(dicToken.self, from: data)
                               
                    
                tokenO.refresh_token = json.refresh_token
                tokenO.token = json.token
                sem.signal()
                resultado = true
                    
                print(json)
                    
                } catch {
                        sem.signal()
                        print(error)
                    }
                }
                   
            }.resume()
               
        sem.wait()
        
        return resultado
    }
    
//    Funcion estatica encargada de general el token para refrescar el el login, se le pasan los parametros necesarios para el regustri, ademas del token de refresco. Delvuelvo el nuevo token.
    
    static func postRefresh(username : String, password : String, mac : String, bundleId : String, version : String, url: String, tokenR: String ) -> String {

//        Se crea un semaforo para realizar la sicronizaccion del codigo.
        
        let sem = DispatchSemaphore(value: 0)
        
//        creo un diccionario para regoer los valores que devuelve la peticion,
        
        struct dicToken: Codable {
            var refresh_token: String
            var token: String
        }
        
        var nToken: String = ""
        
//      establezco los parametros del body
        
        let parameters = ["username": username, "password" : password, "mac" : mac, "bundleId" : bundleId, "version" : version, "token": tokenR]
        
//        genero la url, digo el metodo que voy a usar y añado el body.
        
        guard let urllet = URL(string: (url + "/refresh" )) else { return "Error" }
        var request = URLRequest(url: urllet)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return "Error"  }
        request.httpBody = httpBody
           
//        realizo la peticion
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
                   
            if let data = data {
                do {
                    
// guardo el resultado en el diccionario, reasigno los valores, y desbloqueo el semaforo.
                    
                    let json = try JSONDecoder().decode(dicToken.self, from: data)
                               
                    nToken = json.token
                    
                    sem.signal()
                    
                    print(json)
                    } catch {
                        sem.signal()
                        print(error)
                    }
                }
                   
            }.resume()
             
//        bloqueo el semafora hasta que tenga respuesta
        sem.wait()
        
        return nToken
    }
    
}
