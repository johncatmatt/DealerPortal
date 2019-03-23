//
//  VehicleCell.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VehicleCell: UITableViewCell {

    
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var yrmakemod: UILabel!
    @IBOutlet weak var curpay: UILabel!
    @IBOutlet weak var curtailduenet: UILabel!

    
    
    func setVehicles(v: VehicleData){
        
        if v.VIN.contains("INVALID"){
             vin.text = "\(v.VIN)"
            yrmakemod.text = ""
            curpay.text = ""
            curtailduenet.text = ""
        }else{
            vin.text = "VIN: \(v.VIN)"
            yrmakemod.text = "\(v.YrMakeMod)"
            curpay.text = "CurtailPayment: $\(v.curpay)"
            curtailduenet.text = "Curtailduenet: $\(v.curtailduenet)"
        }
    
    }
}
