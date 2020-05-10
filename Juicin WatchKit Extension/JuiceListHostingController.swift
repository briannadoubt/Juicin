//
//  JuiceListHostingController.swift
//  juicies Extension
//
//  Created by Brianna Lee on 5/9/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class JuiceListHostingController: WKHostingController<JuiceListView> {
    
    override var body: JuiceListView {
        let juiceListView = JuiceListView()
        return juiceListView
    }
}
