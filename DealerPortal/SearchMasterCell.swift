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
    
    
    @IBOutlet weak var btndealerNo: UIButton!
    
    //var CellTitle: String = ""
    var vdata: SearchMasterData = SearchMasterData(dealerNo: "", cifNo: "", company: "", lineAmount: "", outstand: "", units: "")
    //var v: VCNewVehList = nil
    
    func setSearchMaster(v: SearchMasterData){
        
        vdata = v
        
            for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
                btndealerNo.setTitle(NSLocalizedString("\(v.dealerNo)", comment: ""), for: state)
                lblcompany.text = "\(v.company)"
            
        
            }
    
    }
    
    
}
