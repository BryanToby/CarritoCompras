//
//  HomeViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 27/06/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let baseUrl = "http://45.55.9.40:8080/product"
    let show = "showHomeDetalle"
    
    var imagesCel = [JSON]()
    var totalCel = [[JSON]]()
    var nameCel = [JSON]()
    var priceCel = [JSON]()
    var numberImage = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    
    var inicio: [InicioCelulares]! = nil {
        didSet{
            guard let inic = inicio else {
                inicio = nil
                return
            }
            inicio = inic
            
        }
    }
    
    
    //oulet collection
    @IBOutlet weak var celularesCollectionView: UICollectionView!
    
    //Prueba de datos de totales
    
    //override
    override func viewDidLoad() {
        super.viewDidLoad()
        celularesCollectionView.delegate = self
        celularesCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("entra pa consumir")
        Alamofire.request("\(HomeViewController.baseUrl)").responseJSON { (response) in
            if response.result.description == "FAILURE" || response.data == nil{
                print(response.result.error!.localizedDescription)
                if response.response?.statusCode == 404 {
                    self.errorHelper(title: "Hubo un error", msg: "Error 404 Servidor")
                }
                return
            }
            if let data = response.data {
                if let readableJson = JSON(data: data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil).dictionary {
                    var contactos = [InicioCelulares]()
                    
                    for i in 0 ..< (readableJson["data"]!.count) {
                        self.imagesCel = readableJson["data"]![i]["images"].array!
                        self.nameCel.append(readableJson["data"]![i]["name"])
                        self.priceCel.append(readableJson["data"]![i]["priceNow"])
                        self.totalCel.append(self.imagesCel)
                    }
                    print("aca esta los cels")
                    print(self.totalCel[10])
                    
                    
                    for cont in (readableJson["data"]?.array)! {
                        let ct = InicioCelulares(json: cont)
                        ct.simpleDescription()
                        contactos.append(ct)
                    }
                    self.inicio = contactos
                    DispatchQueue.main.async {
                        self.celularesCollectionView.reloadData()
                    }
                    DispatchQueue.main.async(execute: {
                    })
                    
                }
                else {
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    //funciones
    func errorHelper(title:String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    
    //funciones collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == celularesCollectionView {
            
            if inicio == nil {
                return 1
            }else{
                if inicio.count == 0{
                    return 1
                }else{
                    return inicio.count
                }
            }
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  collectionView == celularesCollectionView {
            if inicio != nil{
                if inicio.count == 0{
                    let cellAll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAll", for: indexPath as IndexPath)
                    (cellAll.viewWithTag(2) as! UILabel).text = "no jala ni mrd csm"
                    return cellAll
                }else{
                    let cellAll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAll", for: indexPath as IndexPath)
                    (cellAll.viewWithTag(2) as! UILabel).text = "\(inicio[indexPath.row].name)"
                    (cellAll.viewWithTag(3) as! UILabel).text = "\(inicio[indexPath.row].categoria)"
                    (cellAll.viewWithTag(4) as! UILabel).text = "S/.\(inicio[indexPath.row].priceNow)"
                    
                    let catPictureURL = URL(string: "\(totalCel[numberImage[indexPath.row]][3])")!
                    print(catPictureURL)
                    let session = URLSession(configuration: .default)
                    let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                        if let e = error{
                        } else{
                            if let res = response as? HTTPURLResponse{
                                print("Downloaded cat picture with response code \(res.statusCode)")
                                if let imageData = data {
                                    let imageImage2 = cellAll.viewWithTag(1) as! UIImageView
                                    imageImage2.image = UIImage(data: imageData)
                                    imageImage2.contentMode = UIViewContentMode.scaleAspectFit
//                                    let image = UIImage(data: imageData)
                                } else {
                                    print("Couldn't get image: Image is nil")
                                }
                            } else {
                                print("Couldn't get response code for some reason")
                            }
                        }
                    }
                    downloadPicTask.resume()
  
                    return cellAll
                }
            } else{
                let cellAll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAll", for: indexPath as IndexPath)
                (cellAll.viewWithTag(2) as! UILabel).text = "no jala ni mrd"
                return cellAll
            }
        }
            
        else {
            let cellEvents3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTestimonio", for: indexPath as IndexPath)
            return cellEvents3
        }
        
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let withCell2 = 345
        let heigthCell2 = 70
        
        if  collectionView == celularesCollectionView {
            return CGSize(width: (withCell2), height: (heigthCell2))
        }
        return CGSize(width: ((withCell2)), height: (heigthCell2))
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.performSegue(withIdentifier: show, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == show {
            let indexPaths = self.celularesCollectionView.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            
            let vc = segue.destination as! HomeDetalleViewController
            
            print("")
            print("imprimira el indes")
            print(indexPath.row)
            vc.stringImage = self.totalCel[indexPath.row]
            vc.stringName = "\(self.nameCel[indexPath.row])"
            vc.stringPrecio = "\(self.priceCel[indexPath.row])"
    
        }
        
    }
    
}



















