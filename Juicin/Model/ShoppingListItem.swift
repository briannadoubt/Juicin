//
//  ShoppingListItem.swift
//  Juicies
//
//  Created by Brianna Lee on 5/9/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import Foundation
import CoreData

@objc(ShoppingListItem)
class ShoppingListItem: NSManagedObject {
    
    typealias ID = String
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var quantity: Int
    @NSManaged var isComplete: Bool
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    
}
