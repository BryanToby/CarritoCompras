//
//  BusquedaViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 9/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit

class BusquedaViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var imageBusqueda =  ["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11"]
    
    var codigoBus = ["Apple","Xiaomi","Huawei","Samsung","Lenovo","LG","Sony","Nokia","Motorola","HTC","BlackBerry"]
    
    let show = "showTipo"
    
    @IBOutlet weak var busquedaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        busquedaCollectionView.delegate = self
        busquedaCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Funciones Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == busquedaCollectionView {
            return imageBusqueda.count // Replace with count of your data for collectionViewA
        }
        return 0 // Replace with count of your data for collectionViewB
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == busquedaCollectionView  {
            let cellConsultas = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBus", for: indexPath as IndexPath)
            
            let imageImage = cellConsultas.viewWithTag(1) as! UIImageView
            imageImage.image = UIImage(named:imageBusqueda[indexPath.row])
            imageImage.contentMode = UIViewContentMode.scaleAspectFit

            
            // Set up cell
            return cellConsultas
        }
            
        else {
            let cellEvents3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBus", for: indexPath as IndexPath)
            return cellEvents3
        }
        
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let withCell = 180
        let heigthCell = 205
        let withCell2 = 150
        let heigthCell2 = 200
        
        if  collectionView == busquedaCollectionView {
            return CGSize(width: (withCell2), height: (heigthCell2))
            
        }
        return CGSize(width: ((withCell)), height: (heigthCell))
        
        
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.performSegue(withIdentifier: show, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == show {
            let indexPaths = self.busquedaCollectionView.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            
            let vc = segue.destination as! CelBusquedaViewController
            
            vc.tipoCel = self.codigoBus[indexPath.row]
            
        }
        
    }
  
}
