//
//  TeelViewController.swift
//  Navigate-Controller
//
//  Created by Qingchen on 2022/4/13.
//

import UIKit

class TeelViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigate" {
            let NavigateController = segue.destination as! PinkViewController
            NavigateController.showName = "Hello, " + InputValue.text!
        }
    }
    
    @IBOutlet weak var InputValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teel Screen"
        // Do any additional setup after loading the view.
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
