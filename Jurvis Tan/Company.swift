//
//  Company.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 16/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class Company: NSObject {
   
    var position: String!
    var companyName: String!
    var dateRange: String!
    var jobDescription: String!
    var companyLogo: UIImage!
    
    init(companyName: String,
        andCompanyPosition position: String,
        andDateRange dateRange: String,
        andJobDescription jobDescription: String,
        withCompanyLogo logo: UIImage) {
            self.companyName = companyName
            self.position = position
            self.dateRange = dateRange
            self.jobDescription = jobDescription
            self.companyLogo = logo
            super.init()
    }
}
