//
//  Opcion.swift
//  Moodie
//
//  Created by Maestro on 27/01/17.
//  Copyright © 2017 Maestro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Opcion {
    
    var imagenes : [UIImage] = []
    
    var puntosDrama = 0
    var puntosRomance = 0
    var puntosComedia = 0
    var puntosTerror = 0
    var puntosAccion = 0
    var puntosMusical = 0
    var puntosMisterio = 0
    
    var imagenesCargadas = 0
    
    
    init(){
        
    }
    
    init(imagenes : [UIImage], puntosDrama : Int, puntosRomance : Int, puntosComedia : Int, puntosTerror : Int, puntosAccion : Int, puntosMusical : Int, puntosMisterio : Int){
        self.imagenes = imagenes
        self.puntosDrama = puntosDrama
        self.puntosRomance = puntosRomance
        self.puntosComedia = puntosComedia
        self.puntosTerror = puntosTerror
        self.puntosAccion = puntosAccion
        self.puntosMusical = puntosMusical
        self.puntosMisterio = puntosMisterio
        
    }
    
    init(desdeDiccionario diccionario: NSDictionary, callback : @escaping () -> Void){ // constructort
        
        
        if let customFields = diccionario.value(forKey: "custom_fields") as? NSDictionary{
            
            if let puntosDrama = customFields.value(forKey: "punto_drama") as? NSArray {
                if let valorPuntosDrama = puntosDrama[0] as? String {
                    self.puntosDrama = Int(valorPuntosDrama)!
                
                }
            }
            
            if let puntosRomance = customFields.value(forKey: "punto_romance") as? NSArray {
                if let valorPuntosRomance = puntosRomance[0] as? String {
                    self.puntosRomance = Int(valorPuntosRomance)!
                }
            }
            
            if let puntosComedia = customFields.value(forKey: "punto_comedia") as? NSArray {
                if let valorPuntosComedia = puntosComedia[0] as? String {
                    self.puntosComedia = Int(valorPuntosComedia)!
                }
            }
            
            if let puntosTerror = customFields.value(forKey: "punto_terror") as? NSArray {
                if let valorPuntosTerror = puntosTerror[0] as? String {
                    self.puntosTerror = Int(valorPuntosTerror)!
                }
            }
            
            if let puntosAccion = customFields.value(forKey: "punto_accion") as? NSArray {
                if let valorPuntosAccion = puntosAccion[0] as? String {
                    self.puntosAccion = Int(valorPuntosAccion)!
                }
            }
            
            if let puntosMusical = customFields.value(forKey: "punto_musical") as? NSArray {
                if let valorPuntosMusical = puntosMusical[0] as? String {
                    self.puntosMusical = Int(valorPuntosMusical)!
                }
            }
            
            if let puntosMisterio = customFields.value(forKey: "punto_misterio") as? NSArray {
                if let valorPuntosMisterio = puntosMisterio[0] as? String {
                    self.puntosMisterio = Int(valorPuntosMisterio)!
                }
            }
        }
        
        if let attachments = diccionario.value(forKey: "attachments") as? NSArray{
            
            for attachment in attachments { // la de la izq es nueva variable... la de la derecha es el attachments anterior
                if let diccionarioAttachment = attachment as? NSDictionary {
                    if let urlImagen = diccionarioAttachment.value(forKey: "url") as? String {
                        Alamofire.request("https://moodiedt.azurewebsites.net\(urlImagen)").responseData { response in
                            self.imagenesCargadas += 1
                            if let data = response.result.value {
                                let image = UIImage(data: data)
                                self.imagenes.append(image!)
                            }
                            if self.imagenesCargadas >= 8 {
                                callback()
                                //Avisenle al ViewController qu ya cargué todo
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
}
