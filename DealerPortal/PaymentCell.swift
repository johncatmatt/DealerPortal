//
//  PaymentCell.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/29/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var ymm: UILabel!
    @IBOutlet weak var curpay: UILabel!
    @IBOutlet weak var curtailduenet: UILabel!
    
    func SetLabels(v: VehicleListData){
        vin.text = "VIN: \(v.VIN)"
        ymm.text = v.YrMakeMod
        curpay.text = "Current Payoff: $\(v.curpay)"
        curtailduenet.text = "Curtailment Due: $\(v.curtailduenet)"
    }
    

}
