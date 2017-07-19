//
//  CelBusquedaViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 9/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CelBusquedaViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var celBusquedaCollectionView: UICollectionView!
    
    @IBOutlet weak var tipomarCel: UILabel!
    
    static let baseUrl = "http://45.55.9.40:8080/product"
    let show = "showBusquedaDetalle"
    
    var tipoCel = ""
    //imagenes
    var imagesCel = [JSON]()
    var totalCel = [[JSON]]()
    //datos de solo tipo
    var nameCel = [JSON]()
    var marcaCel = [JSON]()
    var priceCel = [JSON]()

    var inicio: [InicioCelulares]! = nil {
        didSet{
            guard let inic = inicio else {
                inicio = nil
                return
            }
            inicio = inic
            
        }
    }

    //override
    override func viewDidLoad() {
        super.viewDidLoad()
        tipomarCel.text = tipoCel
        celBusquedaCollectionView.delegate = self
        celBusquedaCollectionView.dataSource = self

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
                print("llega acasito")
                if let readableJson = JSON(data: data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil).dictionary {
                    print("entra al if")
                    var contactos = [InicioCelulares]()
                    for cont in (readableJson["data"]?.array)! {
                        print("elo ssad")
                        let ct = InicioCelulares(json: cont)
                        ct.simpleDescription()
                        contactos.append(ct)
                    }
                    self.inicio = contactos
                    
                    print("")
                    print(self.inicio[1].categoria)
                    
                    for i in 0 ..< 32 {
                        if self.inicio[i].categoria == self.tipoCel {
                            print("entro")
                            self.nameCel.append(readableJson["data"]![i]["name"])
                            self.marcaCel.append(readableJson["data"]![i]["categoria"])
                            self.priceCel.append(readableJson["data"]![i]["priceNow"])
                            self.imagesCel = readableJson["data"]![i]["images"].array!
                            self.totalCel.append(self.imagesCel)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.celBusquedaCollectionView.reloadData()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        nameCel.removeAll()
        marcaCel.removeAll()
        priceCel.removeAll()
        totalCel.removeAll()
    }
    
    //funciones
    func errorHelper(title:String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //funciones collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == celBusquedaCollectionView {
            return nameCel.count
            }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  collectionView == celBusquedaCollectionView {
            if inicio != nil{
                if inicio.count == 0{
                    let cellAll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBus", for: indexPath as IndexPath)
                    (cellAll.viewWithTag(2) as! UILabel).text = "no jala ni mrd csm"
                    return cellAll
                }else{
                    let cellAll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBus", for: indexPath as IndexPath)
                    (cellAll.viewWithTag(2) as! UILabel).text = "\(nameCel[indexPath.row])"
                    (cellAll.viewWithTag(3) as! UILabel).text = "\(marcaCel[indexPath.row])"
                    (cellAll.viewWithTag(4) as! UILabel).text = "S/.\(priceCel[indexPath.row])"
                    
                    consumirImage(image: cellAll.viewWithTag(1) as! UIImageView, data: totalCel[indexPath.row][0])
                    
                    return cellAll
                }
            } else{
                let cellAll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBus", for: indexPath as IndexPath)
                (cellAll.viewWithTag(2) as! UILabel).text = "no jala ni mrd"
                return cellAll
            }
        }
            
        else {
            let cellEvents3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBus", for: indexPath as IndexPath)
            return cellEvents3
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let withCell2 = 345
        let heigthCell2 = 70
        
        if  collectionView == celBusquedaCollectionView {
            return CGSize(width: (withCell2), height: (heigthCell2))
        }
        return CGSize(width: ((withCell2)), height: (heigthCell2))
    }
    
    func consumirImage(image:UIImageView, data:JSON) {
        
        let catPictureURL = URL(string: "\(data)")!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error{
                print("Error downloading cat picture: \(e)")
            } else{
                if let res = response as? HTTPURLResponse{
//                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
//                        image = cellAll.viewWithTag(1) as! UIImageView
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

    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.performSegue(withIdentifier: show, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == show {
            let indexPaths = self.celBusquedaCollectionView.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            
            let vc = segue.destination as! BusquedaDetallleViewController
            
            vc.stringImage = self.totalCel[indexPath.row]
            vc.stringName = "\(self.nameCel[indexPath.row])"
            vc.stringPrecio = "\(self.priceCel[indexPath.row])"

        }
        
    }

    
    
}


