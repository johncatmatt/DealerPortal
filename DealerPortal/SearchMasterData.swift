//
//  SearchMasterData.swift
//  DealerPortal
//
//  Created by John Sansoucie on 3/24/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import Foundation

class SearchMasterData {
    
    var dealerNo: String
    var cifNo: String
    var company: String
    var lineAmount: String
    var outstand: String
    var units: String
    
    
    init(dealerNo: String, cifNo: String, company: String, lineAmount: String, outstand: String, units: String) {
        
        if (dealerNo != "" && cifNo != "" && company != "" && lineAmount != ""){
            
            self.dealerNo = dealerNo
            self.cifNo = cifNo
            self.company = company
            
            let templineAmount = Double (lineAmount)
            self.lineAmount = String(format: "%.2f", templineAmount ?? "00000.00000 (UnkonwnError)")
            
            let tempoutstand = Double (outstand)
            self.outstand =  String(format: "%.2f", tempoutstand ?? "00000.00000 (UnkonwnError)")
            
              self.units = units
            
        }else{
            self.dealerNo = "No Data Recieved"
            self.cifNo = ""
            self.company = ""
            self.lineAmount = ""
            self.outstand = ""
            self.units = ""
        }
    }
    
}
