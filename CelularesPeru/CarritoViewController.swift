//
//  CarritoViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 9/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit
import SwiftyJSON

class CarritoViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var carritoCollectionView: UICollectionView!

    @IBOutlet weak var totalCelulares: UILabel!
    
    let show = "showConfirmar"
    var total  = 0
    var totalGuard = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carritoCollectionView.delegate = self
        carritoCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        HomeDetalleViewController.MyVariables.nameVari.append(contentsOf: BusquedaDetallleViewController.MyVariables.nameVari)
        HomeDetalleViewController.MyVariables.priceVari.append(contentsOf: BusquedaDetallleViewController.MyVariables.priceVari)
        HomeDetalleViewController.MyVariables.imageVari.append(contentsOf: BusquedaDetallleViewController.MyVariables.imageVari)
        
        print(HomeDetalleViewController.MyVariables.priceVari)
        
        for i in 0 ..< HomeDetalleViewController.MyVariables.priceVari.count {
            total += Int(HomeDetalleViewController.MyVariables.priceVari[i])!
        }
        
        print("la suma es")
        print(total)
        totalCelulares.text = "S/.\(total)"
        totalGuard = total
        
        DispatchQueue.main.async {
            self.carritoCollectionView.reloadData()
            self.total = 0
            BusquedaDetallleViewController.MyVariables.nameVari = []
            BusquedaDetallleViewController.MyVariables.priceVari = []
            BusquedaDetallleViewController.MyVariables.imageVari = []
        }
        
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Funciones Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == carritoCollectionView {
            return HomeDetalleViewController.MyVariables.nameVari.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == carritoCollectionView  {
            let cellConsultas = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCarrito", for: indexPath as IndexPath)
            
            consumirImage(image: cellConsultas.viewWithTag(1) as! UIImageView, data: HomeDetalleViewController.MyVariables.imageVari[indexPath.row])
            
            let marcaText = cellConsultas.viewWithTag(2) as! UILabel
            marcaText.text = HomeDetalleViewController.MyVariables.nameVari[indexPath.row]
            
            let cantidadText = cellConsultas.viewWithTag(3) as! UILabel
            cantidadText.text = "1"
            
            let precioText = cellConsultas.viewWithTag(4) as! UILabel
            precioText.text = "S/.\(HomeDetalleViewController.MyVariables.priceVari[indexPath.row])"
            
            let totalText = cellConsultas.viewWithTag(5) as! UILabel
            totalText.text =  "S/.\(HomeDetalleViewController.MyVariables.priceVari[indexPath.row])"
            
            // Set up cell
            return cellConsultas
        }
            
        else {
            let cellEvents3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCarrito", for: indexPath as IndexPath)
            return cellEvents3
        }
        
        
    }

    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let withCell = 335
        let heigthCell = 120
        let withCell2 = 335
        let heigthCell2 = 120
        
        if  collectionView == carritoCollectionView {
            return CGSize(width: (withCell2), height: (heigthCell2))
            
        }
        return CGSize(width: ((withCell)), height: (heigthCell))
        
        
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

    @IBAction func comprarProductos(_ sender: Any) {
        if LoginViewController.GlobalStatus.nameVari == false {
            let mapVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main_vc")
            self.present(mapVc, animated: true, completion: nil)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == show {
            
            let vc = segue.destination as! ConfirmarPagoViewController
            vc.cantidadTotal = "\(HomeDetalleViewController.MyVariables.nameVari.count) celulares"
            vc.precioTotal = "S/.\(totalGuard)"
        }
        
    }
 
}
















