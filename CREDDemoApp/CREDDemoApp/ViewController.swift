//
//  ViewController.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickAction() {
        let credVC = CREDCardConfigurator.configCREDCardModule()
        self.navigationController?.pushViewController(credVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
