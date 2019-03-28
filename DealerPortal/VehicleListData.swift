//
//  VehicleData.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import Foundation

class VehicleListData {
    
    var VIN: String
    var YrMakeMod: String
    var curpay: String
    var curtailduenet: String
    var title: String

    
    init(VIN: String, YrMakeMod: String, curpayoff: String, curtailduenet: String, title: String) {
        
        if (VIN != "" && YrMakeMod != "" && curpayoff != "" && curtailduenet != ""){
        
        self.VIN = VIN
        self.YrMakeMod = YrMakeMod
        
        let tempcurpayoff = Double (curpayoff)
        self.curpay = String(format: "%.2f", tempcurpayoff ?? "00000.00000 (UnkonwnError)")
      
        let tempcurtailduenet = Double (curtailduenet)
        self.curtailduenet =  String(format: "%.2f", tempcurtailduenet ?? "00000.00000 (UnkonwnError)")
            
        self.title = title
            
        }else{
            self.VIN = "No Data Recieved"
            self.curpay = ""
            self.YrMakeMod = ""
            self.curtailduenet = ""
            self.title = ""
        }
    }

}
