//
//  Produce.swift
//  Juicies
//
//  Created by Brianna Lee on 5/9/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import Foundation
import CoreData

@objc(Produce)
class Produce: NSManagedObject, Codable {
    
    typealias ID = String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
        case createdAt
        case updatedAt
        case juice
    }
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var quantity: Int
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    @NSManaged var juice: Juice.ID
    
    required convenience init(from decoder: Decoder) throws {
        
        guard
            let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Produce", in: managedObjectContext)
        else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.juice = try container.decode(Juice.ID.self, forKey: .juice)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(juice, forKey: .juice)
    }
}
