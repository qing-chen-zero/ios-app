//
//  ViewController.swift
//  Sqlite-bills
//
//  Created by Qingchen on 2022/4/17.
//

import UIKit
import SQLite3


class ViewController: UIViewController {
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addData(_ sender: Any) {
        // INSERT QUERY
        let insertStatementString = "INSERT INTO USER (NAME, PASSWORD) VALUES (?,?);"
        
        var insertStatementQuery : OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, insertStatementString, -1, &insertStatementQuery, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatementQuery, 1, textField1.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatementQuery, 2, textField2.text ?? "", -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(insertStatementQuery) == SQLITE_DONE {
                textField1.text = ""
                textField2.text = ""
                
                textField1.becomeFirstResponder()
                print("Successfully inserted the record")
            } else {
                print("Error")
            }
            sqlite3_finalize(insertStatementQuery)
        }
        
    }
    
}

