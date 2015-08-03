//
//  DatabaseUtil.swift
//  Espresso Moments
//
//  Created by WiLL on 8/3/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import Foundation

class DatabaseUtil {
    class func getEmptyDatabase(name: String!, error: NSErrorPointer) -> CBLDatabase? {
        if let database = CBLManager.sharedInstance().existingDatabaseNamed(name, error: nil){
            if !database.deleteDatabase(error){
                return nil;
            }
        }
        
        
        return CBLManager.sharedInstance().databaseNamed(name, error: error)
    }
}
