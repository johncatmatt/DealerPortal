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
    @IBOutlet weak var btnTitle: UIButton!
    //var CellTitle: String = ""
    var vdata: VehicleData = VehicleData(VIN: "", YrMakeMod: "", curpayoff: "", curtailduenet: "", title: "")
    //var v: VCNewVehList = nil
    
    func setVehicles(v: VehicleData){
        
        vdata = v
        
        if v.VIN.contains("No Data Recieved"){
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
       // CellTitle = v.title
        
        if vdata.title == ""{
            btnTitle.isHidden = true
        }else{
            btnTitle.isHidden = false
           // btnTitle.titleLabel?.text =  "title: \(vdata.title)"
        }
    
    }
    
    
    @IBAction func ShowTitle(_ sender: Any) {
        //print("The title is " + CellTitle)
        
        
       // let vc = VCNewVehList.self
        
       // vc.ToTitle(VCNewVehList)
        
    }
    
    
}