//
//  RegisterViewController.swift
//  Sqlite-bills
//
//  Created by Qingchen on 2022/4/17.
//

import UIKit
import SQLite3

class RegisterViewController: UIViewController {
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var textView1: UITextView!
    
    @IBAction func addUser(_ sender: Any) {
        // INSERT QUERY
        let insertStatementString = "INSERT INTO USER (NAME, PASSWORD) VALUES (?,?);"
        
        var insertStatementQuery : OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, insertStatementString, -1, &insertStatementQuery, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatementQuery, 1, name.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatementQuery, 2, pwd.text ?? "", -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(insertStatementQuery) == SQLITE_DONE {
                name.text = ""
                pwd.text = ""
                
                name.becomeFirstResponder()
                print("Successfully inserted the record")
            } else {
                print("Error")
            }
            sqlite3_finalize(insertStatementQuery)
        }
        selectUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "USER MANAGE"
        // Do any additional setup after loading the view.
        selectUser()
    }
    
    func selectUser() {
        // SELECT QUERY
        let selectStatementString = "SELECT NAME, PASSWORD FROM USER;"
        var selectStatementQuery : OpaquePointer?
        var sShowData: String!
        sShowData = "昵称\t\t\t密码\t\t\t\n"
        if sqlite3_prepare_v2(dbQueue, selectStatementString, -1, &selectStatementQuery, nil) == SQLITE_OK {
            while sqlite3_step(selectStatementQuery) == SQLITE_ROW {
                sShowData += String(cString: sqlite3_column_text(selectStatementQuery, 0)) + "\t\t\t" + String(cString:sqlite3_column_text(selectStatementQuery, 1)) + "\n"
            }
            sqlite3_finalize(selectStatementQuery)
        }
        textView1.text =  sShowData ?? ""
    }

}
