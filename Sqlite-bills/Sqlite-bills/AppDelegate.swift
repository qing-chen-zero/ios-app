//
//  AppDelegate.swift
//  Sqlite-bills
//
//  Created by Qingchen on 2022/4/17.
//

import UIKit
import CoreData
import SQLite3

var dbQueue:OpaquePointer!

//Sqlite Db.
var dbURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dbQueue = createAndOpenDatabase() // create and open database + set the pointer
        
        if createTables() == false {
            print("Error in Creating Tables")
        } else {
            print("YAY! Tables Created!")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Sqlite_bills")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createAndOpenDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        
        let url = NSURL(fileURLWithPath: dbURL)
        
        if let pathComponent = url.appendingPathComponent("user.db") {
            let filePath = pathComponent.path
            if sqlite3_open(filePath, &db) == SQLITE_OK {
                print("Successfully opend the databases :) at \(filePath)")
                
                return db
            } else {
                print("Could not open the database")
            }
        } else {
            print("File path is not available.")
        }
        
        return db
    }
    
    func createTables() -> Bool {
        var bRetVal : Bool = false
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT
                                       USER (NAME TEXT NULL, PASSWORD TEXT NULL, EMAIL TEXT NULL)", nil, nil, nil)
        if createTable != SQLITE_OK {
            print("Not able to create table")
            bRetVal = false
        } else {
            bRetVal = true
        }
        return bRetVal
    }

}

