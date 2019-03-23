//
//  DealerData.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 12/26/18.
//  Copyright © 2018 Matthew Sansoucie. All rights reserved.
//

import Foundation

class DealerData {
    
    //static let shared : [DealerData] = DealerData()
    
    var Dealer: String
    
    var VIN: String
    var MkMdlYr: String
    var CurtailDue: String
    var Title: String
    var Payoff: String
    var days: String
    
    var starts : String
    var board : String
        
    var miles : String
    var audit : String
    var titleNum : String
    var titleIn : String
    var titleOut : String
    var refloors : String
    
    var advanceAndSetup : String
    var interestDue : String
    var serviceFees : String
    var phyDamCoverage : String
    var closeOutFee : String
    var titleCharge : String
    var curtailmentsRecvd : String
    var dailyInterest : String
    
    //constructor
   init(Dealer: String, VIN: String, MkMdlYr: String, CurtailDue: String, title: String, payoff: String, days: String, starts : String, board : String, miles : String, audit : String, titleNum : String, titleIn : String, titleOut : String, refloors : String, advanceAndSetip : String, interestDue : String, serviceFees : String, phyDamCoverage : String, closeOutFee : String, titleChange : String, curtailmentsRecvd : String, dailyInterest : String){
        self.Dealer = Dealer
    
        self.VIN = VIN
        self.MkMdlYr = MkMdlYr
        self.CurtailDue = CurtailDue
        self.Title = title
        self.Payoff = payoff
        self.days = days
    
        self.starts = starts
        self.board = board
        self.miles = miles
        self.audit = audit
        self.titleNum = titleNum
        self.titleIn = titleIn
        self.titleOut = titleOut
        self.refloors = refloors
        self.advanceAndSetup = advanceAndSetip
        self.interestDue = interestDue
        self.serviceFees = serviceFees
        self.phyDamCoverage = phyDamCoverage
        self.closeOutFee = closeOutFee
        self.titleCharge = titleChange
        self.curtailmentsRecvd = curtailmentsRecvd
        self.dailyInterest = dailyInterest
    }

}
