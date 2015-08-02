//
//  FeedItem.swift
//  Espresso Moments
//
//  Created by WiLL on 8/1/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import Foundation
import CoreData

@objc (FeedItem)

class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
