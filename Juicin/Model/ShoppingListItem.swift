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
class ShoppingListItem: NSManagedObject, Codable {
    
    typealias ID = String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
        case isComplete
        case createdAt
        case updatedAt
    }
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var quantity: Int
    @NSManaged var isComplete: Bool
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    
    required convenience init(from decoder: Decoder) throws {
        
        guard
            let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ShoppingListItem", in: managedObjectContext)
        else {
            fatalError("Failed to decode ShoppingListItem")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.isComplete = try container.decode(Bool.self, forKey: .isComplete)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(isComplete, forKey: .isComplete)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}
