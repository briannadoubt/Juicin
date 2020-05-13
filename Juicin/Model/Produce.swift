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
class Produce: NSManagedObject {
    
    typealias ID = String
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var quantity: Int
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    @NSManaged var juice: NSSet
    
    public var juiceArray: [Produce] {
        let set = juice as? Set<Produce> ?? []
        return set.sorted {
            $0.name < $1.name
        }
    }
}
