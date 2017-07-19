//
//  HomeDetalleViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 9/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit
import SwiftyJSON


class HomeDetalleViewController: UIViewController {

    //Datos para consumir
    var stringImage = [JSON]()
    var stringName = ""
    var stringPrecio = ""
    var imagePrueba = UIImageView()
    
    //Oulets de los datos para consumer
    @IBOutlet weak var imagecel1: UIImageView!
    @IBOutlet weak var imagecel2: UIImageView!
    @IBOutlet weak var imagecel3: UIImageView!
    @IBOutlet weak var imagelcel4: UIImageView!
    @IBOutlet weak var imagecel5: UIImageView!
    
    @IBOutlet weak var marcaCel: UILabel!
    @IBOutlet weak var descripcionCel: UILabel!
    @IBOutlet weak var precioCel: UILabel!
    
    @IBOutlet weak var nameCel: UILabel!
    @IBOutlet weak var priceCel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagecel1.image = imagecel2.image
        imagecel2.image = imagecel3.image
        imagecel3.image = imagelcel4.image
        imagelcel4.image = imagecel5.image
        imagecel5.image = imagecel1.image
        pintarImage()
        nameCel.text = "\(stringName)"
        priceCel.text = "S/.\(stringPrecio)"
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Acciones
    @IBAction func agregarCarrito(_ sender: Any) {
        
        
    }
    
    func pintarImage() {
        consumirImage(image: imagecel1, data: stringImage[0])
        consumirImage(image: imagecel2, data: stringImage[1])
        consumirImage(image: imagecel3, data: stringImage[2])
        consumirImage(image: imagelcel4, data: stringImage[3])
        consumirImage(image: imagecel5, data: stringImage[4])

    }
    
    func consumirImage(image:UIImageView, data:JSON) {
        let catPictureURL = URL(string: "\(data)")!
        print(catPictureURL)
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            if let e = error{
                print("Error downloading cat picture: \(e)")
            } else{
                if let res = response as? HTTPURLResponse{
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        image.image = UIImage(data: imageData)
                        image.contentMode = UIViewContentMode.scaleAspectFit
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
    }
    
    @IBAction func botton1(_ sender: Any) {
        imagePrueba.image = imagecel1.image
        imagecel1.image = imagecel2.image
        imagecel2.image = imagePrueba.image
    }
    
    @IBAction func botton2(_ sender: Any) {
        imagePrueba.image = imagecel1.image
        imagecel1.image = imagecel3.image
        imagecel3.image = imagePrueba.image
    }
    
    @IBAction func botton3(_ sender: Any) {
        imagePrueba.image = imagecel1.image
        imagecel1.image = imagelcel4.image
        imagelcel4.image = imagePrueba.image
    }
    
    @IBAction func botton4(_ sender: Any) {
        imagePrueba.image = imagecel1.image
        imagecel1.image = imagecel5.image
        imagecel5.image = imagePrueba.image
    }
    
    @IBAction func AñadirCarrito(_ sender: Any) {
        MyVariables.nameVari.append(stringName)
        MyVariables.priceVari.append(stringPrecio)
        MyVariables.imageVari.append(stringImage[0])
        self.errorHelper(title: "Prodcuto agregado", msg: "Revise su carrito")

    }
    
    func errorHelper(title:String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    struct MyVariables{
        static var nameVari = [String]()
        static var priceVari = [String]()
        static var imageVari = [JSON]()

    }

}













