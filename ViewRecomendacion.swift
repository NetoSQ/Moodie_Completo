//
//  ViewRecomendacion.swift
//  Moodie
//
//  Created by Ernesto Salazar on 02/03/17.
//  Copyright © 2017 Maestro. All rights reserved.
//

import UIKit
import Alamofire

class ViewRecomendacion: UIViewController {
    
    var genero = 0
    var NombreGenero = ""
    
    @IBOutlet weak var ImgFondo: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblAno: UILabel!
    
    

    
    @IBAction func doTapOnNext(_ sender: Any) {
        obtenerOpciones(genero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        obtenerOpciones(genero) // se manda a llamar obtener opciones
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        obtenerOpciones(genero)
    }

    
    func obtenerOpciones(_ genero: Int){
        let rndm = Int(arc4random_uniform(10) + 1)
        Alamofire.request("http://www.omive.com/search", method: .post, parameters: ["genres[]" : genero, "start" : rndm, "showtype" : 0])
        //Alamofire.request("http://www.omive.com/search", method: .post, parameters: ["genres[]" : 9, "start" : 0, "showtype" : 0])
            .responseJSON {
                response in
                /*print("Request: \(response.request)")
                print("Response: \(response.response)")
                print("Error: \(response.error)")
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8){
                    print("Data: \(utf8Text)")
                }*/
    
                if let arregloRespuesta = response.result.value as? NSArray { // si tienes un valor que puede ser casteado como ns dictionary... continua
                    
                    for pelicula in arregloRespuesta {
                        
                        if let diccionarioPeliculas = pelicula as? NSDictionary {
                            
                            if let urlImagen = diccionarioPeliculas.value(forKey: "image") as? String {
                                Alamofire.request(urlImagen).responseData { response in
            
                                    if let data = response.result.value {
                                        let image = UIImage(data: data)
                                        self.ImgFondo.image = image
                                    }
                                }
                            }
                            
                            if let tituloPelicula = diccionarioPeliculas.value(forKey: "name") as? String {
                                self.lblTitulo.text = tituloPelicula
                            }
                            
                            if let reseña = diccionarioPeliculas.value(forKey: "synopsis") as? String {
                                self.lblDescripcion.text = reseña
                            }
                            
                            self.lblAno.text = self.NombreGenero
                            
                            
                            break
                        }
                    }
                }
        }
    }
}
