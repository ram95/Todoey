//
//  AppDelegate.swift
//  Todoey
//
//  Created by shree ram on 30/08/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     //   print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!)
        print(Realm.Configuration.defaultConfiguration.fileURL!)

//    
//        let config = Realm.Configuration(
//            
//            schemaVersion: 1,
//            
//            migrationBlock: { migration, oldSchemaVersion in
//                
//                if (oldSchemaVersion < 1) {
//                    migration.enumerateObjects(ofType: Item.className()) { (old, new) in
//                        new!["dateCreated"] = Date()
//                    }
//                }
//        })
//        
//        Realm.Configuration.defaultConfiguration = config
        do{
            _ = try Realm()
        } catch {
            print("Error In Inlilastion \(error)")
        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {

        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
        
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}



