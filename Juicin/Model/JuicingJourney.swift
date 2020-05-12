//
//  JuicingJourney.swift
//  Juicin
//
//  Created by Brianna Lee on 5/10/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import Foundation
import CoreData

//class JuicingJourney: NSManagedObject {
//
//    @NSManaged var days: NSSet
//
//}
//
//class JuicingJourneyDay {
//
//}


struct JuicingJourney {
    var phase: JuicingJourneyPhase
    var days: [JuicingJourneyDay]
}

enum JuicingJourneyPhase {
    case planning
    case shopping
    case juicing
}

struct JuicingJourneyDay {
    var itinerary: JuicingJourneyDayItinerary
}

struct JuicingJourneyDayItinerary {
    
}
