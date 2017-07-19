//
//  ConfirmarPagoViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 10/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit

class ConfirmarPagoViewController: UIViewController,UITextFieldDelegate {

    var precioTotal = ""
    var cantidadTotal = ""
    
    @IBOutlet weak var numeroTarjeta: UITextField!
    @IBOutlet weak var nombreTarjeta: UITextField!
    @IBOutlet weak var mesExpiracion: UITextField!
    @IBOutlet weak var añoExpiracion: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var envioCel: UITextField!
    
    
    //oulets
    
    @IBOutlet weak var cantidadCelulares: UILabel!
    @IBOutlet weak var precioCelulares: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numeroTarjeta.delegate = self
        nombreTarjeta.delegate = self
        mesExpiracion.delegate = self
        añoExpiracion.delegate = self
        cvv.delegate = self
        envioCel.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cantidadCelulares.text = cantidadTotal
        precioCelulares.text = precioTotal
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numeroTarjeta.resignFirstResponder()
        nombreTarjeta.resignFirstResponder()
        mesExpiracion.resignFirstResponder()
        añoExpiracion.resignFirstResponder()
        cvv.resignFirstResponder()
        envioCel.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func errorHelper(title:String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func verificarTarjeta(_ sender: Any) {
        self.errorHelper(title: "Tarjeta Validada", msg: "Proceda con el pago")

    }
    
    @IBAction func pagarProducto(_ sender: Any) {
        self.errorHelper(title: "Compra Exitosa", msg: "Revise su historial de pedidos")

    }
    
    
}


