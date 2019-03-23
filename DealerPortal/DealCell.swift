//
//  TableViewCell.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 12/26/18.
//  Copyright © 2018 Matthew Sansoucie. All rights reserved.
//

import UIKit

//repersents each of the cells inside the tableview
class DealCell: UITableViewCell {

    //outlets of all the deals information
    @IBOutlet weak var VIN: UILabel!
    @IBOutlet weak var MkMdlYr: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var CurtailDue: UILabel!
    @IBOutlet weak var payoff: UILabel!
    @IBOutlet weak var days: UILabel!
    
  
    
    //fills the cell labels with their information
    func setDeal(d: DealerData){
        VIN.text = "VIN: \(d.VIN)"
        MkMdlYr.text = "MkMdYr: \(d.MkMdlYr)"
        title.text = "Title: \(d.Title)"
        CurtailDue.text = "CurtailDue: \(d.CurtailDue)"
        payoff.text = "Payoff: \(d.Payoff)"
        days.text = "Days: \(d.days)"
    }
    
}
