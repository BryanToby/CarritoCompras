//
//  MiAccountViewController.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 27/06/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit

class MiAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if LoginViewController.GlobalStatus.nameVari == false {
            let mapVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main_vc")
            self.present(mapVc, animated: true, completion: nil)

        } else {
            print("no funciona :c")
        }
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        LoginViewController.GlobalStatus.nameVari = false
        let mapVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main_vc")
        self.present(mapVc, animated: true, completion: nil)
    }
    @IBAction func todosPedidos(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2

    }
    @IBAction func pendienteRece(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2

    }
    @IBAction func pedientePago(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2

    }
    @IBAction func pendienteVal(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2

    }
    @IBAction func listaDeseos(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2

    }
    @IBAction func preferencialist(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2

    }
    
}
