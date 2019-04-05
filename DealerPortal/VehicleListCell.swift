//
//  VehicleCell.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VehicleListCell: UITableViewCell {

    
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var yrmakemod: UILabel!
    @IBOutlet weak var curpayoff: UILabel!
    @IBOutlet weak var curtailduenet: UILabel!
    @IBOutlet weak var Auction: UILabel!
    
    
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var btnTitle: UIButton!
    //var CellTitle: String = ""
    var vdata: VehicleListData = VehicleListData(VIN: "", YrMakeMod: "", curpayoff: "", curtailduenet: "", title: "", Auction: "")
    //var v: VCNewVehList = nil
    
    func setVehicles(v: VehicleListData){
        
        vdata = v
        
        if v.VIN.contains("No Data Recieved"){
            vin.text = "\(v.VIN)"
            yrmakemod.text = ""
            curpayoff.text = ""
            curtailduenet.text = ""
            Auction.text = ""
        }else{
            vin.text = "VIN: \(v.VIN)"
            yrmakemod.text = "\(v.YrMakeMod)"
            curpayoff.text = "Current Payoff: $\(v.curpay)"
            curtailduenet.text = "Curtailment Due: $\(v.curtailduenet)"
            Auction.text = v.Auction
        }
       // CellTitle = v.title
        
        if vdata.title == ""{
            btnTitle.isHidden = true
        }else{
            btnTitle.isHidden = false
           // btnTitle.titleLabel?.text =  "title: \(vdata.title)"
        }
    
    }
    
    
}
