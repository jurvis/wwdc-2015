//
//  PersonalApp.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PersonalApp: NSObject {
    
    var title: String!
    var subtitle: String!
    var appDescription: String!
    var appIcon: UIImage!
    
    init(title: String,
        withSubtitle subtitle: String,
        andDescription description: String,
        andAppIcon appIcon: UIImage) {
            self.title = title
            self.subtitle = subtitle
            self.appDescription = description
            self.appIcon = appIcon
            super.init()
    }

}
