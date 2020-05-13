//
//  Juice.swift
//  Juicies
//
//  Created by Brianna Lee on 5/9/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

@objc(Juice)
class Juice: NSManagedObject {
    
    typealias ID = String
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var color: String
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    @NSManaged var isEditing: Bool
    @NSManaged var produce: NSSet
    
    public var produceArray: [Produce] {
        let set = produce as? Set<Produce> ?? []
        return set.sorted {
            $0.name < $1.name
        }
    }
}
