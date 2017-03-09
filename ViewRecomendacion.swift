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
    
    @IBOutlet weak var ImgFondo: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    var generoGanador = [1, 6, 7, 9, 15, 17, 21]
    var n = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        obtenerOpciones() // se manda a llamar obtener opciones
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func obtenerOpciones(){
        print("Obtener opciones..!")
        Alamofire.request("http://www.omive.com/search", method: .post, parameters: ["genres[]" : 9, "start" : 4, "showtype" : 0])
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
                            break
                        }
                    }
                }
        }
    }
}
