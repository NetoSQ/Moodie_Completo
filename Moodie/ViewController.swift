//
//  ViewController.swift
//  Moodie
//
//  Created by Maestro on 27/01/17.
//  Copyright © 2017 Maestro. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var preguntaActual = 0
    var opciones : [Opcion] = []
    
    var puntosDrama = 0
    var puntosRomance = 0
    var puntosComedia = 0
    var puntosTerror = 0
    var puntosAccion = 0
    var puntosMusical = 0
    var puntosMisterio = 0
    
    var opcionesCargadas = 0
    
    @IBOutlet weak var imgOpcion1: UIImageView!
    @IBOutlet weak var imgOpcion2: UIImageView!
    
    @IBAction func doTapOpcion1(_ sender: AnyObject) {
        
        puntosDrama += opciones[(preguntaActual*2)].puntosDrama
        puntosRomance += opciones[(preguntaActual*2)].puntosRomance
        puntosComedia += opciones[(preguntaActual*2)].puntosComedia
        puntosTerror += opciones[(preguntaActual*2)].puntosTerror
        puntosAccion += opciones[(preguntaActual*2)].puntosAccion
        puntosMusical += opciones[(preguntaActual*2)].puntosMusical
        puntosMisterio += opciones[(preguntaActual*2)].puntosMisterio
        
        siguientePregunta()
        
    }
    
    @IBAction func doTapOpcion2(_ sender: AnyObject) {
        
        puntosDrama += opciones[(preguntaActual*2)+1].puntosDrama
        puntosRomance += opciones[(preguntaActual*2)+1].puntosRomance
        puntosComedia += opciones[(preguntaActual*2)+1].puntosComedia
        puntosTerror += opciones[(preguntaActual*2)+1].puntosTerror
        puntosAccion += opciones[(preguntaActual*2)+1].puntosAccion
        puntosMusical += opciones[(preguntaActual*2)+1].puntosMusical
        puntosMisterio += opciones[(preguntaActual*2)+1].puntosMisterio
        
        siguientePregunta()
    }
    
    func siguientePregunta(){
        
        preguntaActual += 1
        
        if preguntaActual >= 5 {
            self.performSegue(withIdentifier: "goToSugerencia", sender: self)
            
        }else{
            imgOpcion1.stopAnimating()
            imgOpcion1.animationImages = opciones[preguntaActual*2].imagenes
            imgOpcion1.startAnimating()
            
            imgOpcion2.stopAnimating()
            imgOpcion2.animationImages = opciones[(preguntaActual*2)+1].imagenes
            imgOpcion2.startAnimating()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgOpcion1.animationDuration = 1
        imgOpcion2.animationDuration = 1
        obtenerOpciones() // se manda a llamar obtener opciones
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callbackCargaOpcion() {
        opcionesCargadas += 1
        
        if opcionesCargadas >= 10 {
            
            //Inicializar las animaciones
            imgOpcion1.stopAnimating()
            imgOpcion1.animationImages = opciones[preguntaActual*2].imagenes
            imgOpcion1.startAnimating()
            
            imgOpcion2.stopAnimating()
            imgOpcion2.animationImages = opciones[(preguntaActual*2)+1].imagenes
            imgOpcion2.startAnimating()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSugerencia" {
        
        var viewControllerDestino =  segue.destination as! ViewRecomendacion
            //viewControllerDestino.generoGanador =
            
        }
    }
    
    
    
    
    // construyendo desde los assets
    
    func obtenerOpciones(){

        
        Alamofire.request("https://moodiedt.azurewebsites.net/api/get_posts/", parameters: ["post_type" : "pregunta"])
            .responseJSON {
            response in
            if let diccionarioRespuesta = response.result.value as? NSDictionary { // si tienes un valor que puede ser casteado como ns dictionary... continua
                if let arregloPosts = diccionarioRespuesta.value(forKey: "posts") as? NSArray  {
                    
                    for post in arregloPosts {
                        if let diccionarioPost = post as? NSDictionary  {
                            
                            self.opciones.append(Opcion(desdeDiccionario: diccionarioPost, callback : self.callbackCargaOpcion))
                        }
                    }
                }
            }
        }
    }
    
}

