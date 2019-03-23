//
//  VCMoreDetailViewController.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 12/26/18.
//  Copyright © 2018 Matthew Sansoucie. All rights reserved.
//

import UIKit

class OLDVCMoreDetail: UIViewController {

    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtOtherPaymentAmount: UITextField!
    @IBOutlet weak var btnOtherPaymentAmount: UIButton!
    
    
    var curtailPayoffOther = 999
    var selectedDealData: [DealerData] = []
    
    //page loads and populates the labels with the temp values filled by the prepare segue
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if curtailPayoffOther == 2 {
            txtOtherPaymentAmount.isHidden = false
            btnOtherPaymentAmount.isHidden = false
        }else{
            txtOtherPaymentAmount.isHidden = true
            btnOtherPaymentAmount.isHidden = true
        }
        
        
        
    }
}

//tableview extension
extension OLDVCMoreDetail: UITableViewDelegate, UITableViewDataSource{
    
    //number of rows in the table (Will be a constant amount)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "1. Dealer: \(selectedDealData[0].Dealer)"
        case 1:
            cell.textLabel?.text = "2. Vehicle/VIN: \(selectedDealData[0].MkMdlYr) / \(selectedDealData[0].VIN)" //(Miles:\(selectedDealsData[0].miles))
        case 2:
            cell.textLabel?.text = "3. Fund Date: "
        case 3:
            cell.textLabel?.text = "4. Advance & Setup: \(selectedDealData[0].advanceAndSetup)"
        case 4:
            cell.textLabel?.text = "5. Interest: \(selectedDealData[0].interestDue)"
        case 5:
            cell.textLabel?.text = "6. Service Fee: \(selectedDealData[0].serviceFees)"
        case 6:
            cell.textLabel?.text = "7. Phys Damage Cov: \(selectedDealData[0].phyDamCoverage)"
        case 7:
            cell.textLabel?.text = "8. Payoff Fee: \(selectedDealData[0].closeOutFee)"
        case 8:
            cell.textLabel?.text = "9. Title Charge: \(selectedDealData[0].titleCharge)"
        case 9:
            cell.textLabel?.text = "10. Prev. Payment made: \(selectedDealData[0].curtailmentsRecvd)"
        case 10:
            cell.textLabel?.text = "11. Requested Payment Date: "
            
        case 11: //handles the payment option the user selected before opening the page
            //Will be curtailment, payoff or other payment
            var pmtOption = ""
            if curtailPayoffOther == 0 {
                pmtOption = "Curtailment Payment: \(selectedDealData[0].CurtailDue)"
            }else if curtailPayoffOther == 1 {
                pmtOption = "Payoff Amount: \(selectedDealData[0].Payoff)"
            }else if curtailPayoffOther == 2 {
                //other paymnet amount, needs to be set by dealer
                pmtOption = "Other Payment: $0.00"
            }else{
               pmtOption = "Error"
            }
            cell.textLabel?.text = "12. \(pmtOption)"
            
        case 12:
            cell.textLabel?.text = "13. Payment Method: "
        case 13:
            cell.textLabel?.text = "14. Payoff will increase by Per Diem Fees & Interest if funds are posted AFTER the above Payoff Date"
        case 14:
            cell.textLabel?.text = "15. Per Diem Fees & Interest: \(selectedDealData[0].dailyInterest)"
        case 15:
            cell.textLabel?.text = "16. By Selecting the Payoff or Curtail Button, Dealer is autherorizing an Electronic Payment to Autouse "
        case 16:
            if curtailPayoffOther == 0 {
                cell.textLabel?.text = "17. ReFloor Amount: "
            }else{
                 cell.textLabel?.text = "17. "
            }
        default:
            cell.textLabel?.text = "? unkown indexpath.row value: \(String(indexPath.row))"
        }
        //allows for multiple lines in the cell
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.textColor = .black
        
        if indexPath.row % 2 == 0{//even number
         cell.backgroundColor = .white
        }else{
         cell.backgroundColor = UIColor.lightGray
        }
       
        return cell
    }
    
    
    //handels the table header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var myPmtOption : String
        if curtailPayoffOther == 0 {
            myPmtOption = "Curtailment Payment"
        }else if curtailPayoffOther == 1 {
           myPmtOption = "Payoff Payment"
        }else if curtailPayoffOther == 2 {
            myPmtOption = "Other Payment"
        }else{
            myPmtOption = "Error"
        }
        let label = UILabel()
        label.text = myPmtOption
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    
    
}
