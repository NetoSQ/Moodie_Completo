//
//  ViewDisfruta.swift
//  Moodie
//
//  Created by Ernesto Salazar on 09/03/17.
//  Copyright © 2017 Maestro. All rights reserved.
//
import UIKit
import Foundation
import Alamofire

class ViewDisfruta: UIViewController {

    @IBAction func doTapOnGoQuiz(_ sender: Any) {
        self.performSegue(withIdentifier: "goToQuiz", sender: self)

    }

}
