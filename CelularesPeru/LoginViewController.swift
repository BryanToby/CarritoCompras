//
//  LoginViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 9/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    //Oulets
    //Contenedores
    @IBOutlet weak var containerScroolView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    //Barrar Login View
    @IBOutlet weak var barTengoView: UIView!
    @IBOutlet weak var barCrearView: UIView!
    
    //Opciones Login Button
    @IBOutlet weak var cuentaButton: UIButton!
    @IBOutlet weak var crearButton: UIButton!
    
    //Cuenta TextField
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    //Sesion Button
    @IBOutlet weak var iniciarButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    //Sectiones Views
    @IBOutlet weak var tengoCuentaInfoView: UIView!
    @IBOutlet weak var crearCuentaInfoView: UIView!
    
    
    //var
    var customText = CustomTextField()
    var abajoBaseLine: CGFloat = 0.0
    var anchuraTextField: CGFloat = 0.0
    var stateLogin: Bool = true
    
    //Override
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        emailTextField.delegate = self
        passTextField.delegate = self
        inicioApp()
        containerView.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Funciones
    //Al iniciar la aplicación
    func inicioApp() {
        abajoBaseLine = 33
        anchuraTextField = (self.view.frame.width) - 58
        tengoCuentaInfoView.isHidden = false
        crearCuentaInfoView.isHidden = true
        customTextBase(text: emailTextField, r: 151.0/255.0, g: 151.0/255.0, b: 151.0/255.0)
        customTextBase(text: passTextField, r: 151.0/255.0, g: 151.0/255.0, b: 151.0/255.0)
    }
    //Poner colores a los views y button tengo cuenta y crear cuenta
    func customAccountButton(view1: UIView,view2: UIView,button1: UIButton, button2: UIButton) {
        view1.backgroundColor = UIColor(red: 230.0/255.0, green: 74.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        button1.setTitleColor(UIColor(red: 230.0/255.0, green: 74.0/255.0, blue: 60.0/255.0, alpha: 1.0), for: UIControlState.normal)
        view2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        button2.setTitleColor(UIColor.init(red: 227.0/255.0, green: 227.0/255.0, blue: 227.0/255.0, alpha: 1.0), for: UIControlState.normal)
        
    }
    //Cambiar los enunciados del boton negro
    func customSesionMyButton(){
        iniciarButton.setTitle("INICIAR SESIÓN", for: .normal)
        facebookButton.setTitle("INICIAR CON FACEBOOK", for: .normal)
        
    }
    //Cambiar los enunciados del boton azul
    func customSesionCreateButton(){
        iniciarButton.setTitle("REGISTRARME", for: .normal)
        facebookButton.setTitle("CON FACEBOOK", for: .normal)
    }
    
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    func dismissKeyboard() {
        containerView.endEditing(true)
    }
    
    //Crear la linea debajo de los TextField
    func customTextBase(text: UITextField, r: Float, g: Float, b: Float) {
        customText.createBaseLine(text, r: r, g: g, b: b, aBl: Float(abajoBaseLine), an: Float(anchuraTextField) )
    }
    
    //Cambio de colores  y movimiento de los textField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let a = (self.view.frame.height/106)
        containerScroolView.setContentOffset(CGPoint(x: 0, y: a*12 ), animated: true)
        
        if ( textField == emailTextField){
            customTextBase(text: emailTextField, r: 51.0/255.0, g: 153.0/255.0, b: 255.0/255.0)
        } else {
            customTextBase(text: passTextField, r: 51.0/255.0, g: 153.0/255.0, b: 255.0/255.0)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerScroolView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        if emailTextField.text == "" {
            customTextBase(text: emailTextField, r: 151.0/255.0, g: 151.0/255.0, b: 151.0/255.0)
            
        }
        if passTextField.text == "" {
            customTextBase(text: passTextField, r: 151.0/255.0, g: 151.0/255.0, b: 151.0/255.0)
        }
        
        if emailTextField.text != "" && passTextField.text != "" {
            iniciarButton.backgroundColor = UIColor.init(red: 26.0/255.0, green: 89.0/255.0, blue: 88.0/255.0, alpha: 1.0)        } else  {
            iniciarButton.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailTextField.text != "" && passTextField.text != "" {
            iniciarButton.backgroundColor = UIColor.init(red: 230.0/255.0, green: 74.0/255.0, blue: 60.0/255.0, alpha: 1.0)        } else  {
            iniciarButton.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
        
        return true
    }
    
    //Acciones
    //Al cambiar de opcion a crear cuenta
    @IBAction func crearCuentaButton(_ sender: Any) {
        customAccountButton(view1: barCrearView, view2: barTengoView, button1: crearButton, button2: cuentaButton)
        customSesionCreateButton()
        tengoCuentaInfoView.isHidden = true
        crearCuentaInfoView.isHidden = false
        stateLogin = false
        
    }
    
    //Al cambiar de opcion a tengo cuenta
    @IBAction func tengoCuentaButton(_ sender: Any) {
        customAccountButton(view1: barTengoView, view2: barCrearView, button1: cuentaButton, button2: crearButton)
        customSesionMyButton()
        tengoCuentaInfoView.isHidden = false
        crearCuentaInfoView.isHidden = true
        stateLogin = true
        
    }
    
    //Iniciar sesion o Crear cuenta
    @IBAction func iniciarOCrearCuenta(_ sender: Any) {
        GlobalStatus.nameVari = true
    }
    
    //Iniciar sesion o Crear cuenta con facebook
    @IBAction func iniciaroCrearCuentaFacebook(_ sender: Any) {
        GlobalStatus.nameVari = true
    }
    
    struct GlobalStatus{
        static var nameVari = false
        
    }
}














