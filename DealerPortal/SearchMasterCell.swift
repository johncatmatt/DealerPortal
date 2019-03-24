//
//  SearchMasterCell.swift
//  DealerPortal
//
//  Created by John Sansoucie on 3/24/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class SearchMasterCell: UITableViewCell {

    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var btndealerNo: UIButton!
    
    @IBOutlet weak var lblUnits: UILabel!
    @IBOutlet weak var lblAvail: UILabel!
    @IBOutlet weak var lblOutstand: UILabel!
    
    
    //var CellTitle: String = ""
    var vdata: SearchMasterData = SearchMasterData(dealerNo: "", cifNo: "", company: "", lineAmount: "", outstand: "", units: "")
    //var v: VCNewVehList = nil
    
    func setSearchMaster(v: SearchMasterData){
        
        vdata = v
        
       let myLine = v.lineAmount.replacingOccurrences(of: ".00", with: "")
       let myOutstand = v.outstand.replacingOccurrences(of: ".00", with: "")
       let myUnits = v.units.replacingOccurrences(of: ".00", with: "")
        
       // print(myLine)
            for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
                btndealerNo.setTitle(NSLocalizedString("\(v.dealerNo)", comment: ""), for: state)
                lblcompany.text = "\(v.company)"
                lblLine.text = "Line:$\(myLine)"
                lblOutstand.text = "Out:$\(myOutstand)"
                
                  let intLine = Int(Float(myLine)!)
                  let intOut = Int(Float(myOutstand)!)
                  let intAvail = intLine - intOut
              
                if (intAvail >= 0) {
                      lblAvail.textColor = UIColor.black
                } else {
                    lblAvail.textColor = UIColor.red }
                
        
                
                  lblAvail.text = "Avail:$\(intAvail)"
                
            
                 lblUnits.text = "Active:\(myUnits)"
                
        }
    
    }
    
    
}
