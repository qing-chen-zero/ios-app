//
//  PinkViewController.swift
//  Navigate-Controller
//
//  Created by Qingchen on 2022/4/13.
//

import UIKit

class PinkViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    var showName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pink Screen"
        name.text = showName
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
