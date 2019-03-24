//
//  VCPayment.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/15/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCPayment: UIViewController {
    
 @IBOutlet weak var TableView: UITableView!
 @IBOutlet weak var txtPaymentField: UITextField!
    
 var deal: VehicleData? = nil
 var paymentMethod: String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        /*print("Payment method: " + paymentMethod)
        print(deal!.VIN)
        print(deal!.YrMakeMod)
        print(deal!.curpay)
        print(deal!.curtailduenet)*/
        
        TableView.delegate = self
        TableView.dataSource = self
        txtPaymentField.delegate = self
    }
    
    
    
    func makePayment() {
        //print("Payment Made!)")
    }
    
    @IBAction func makePaymentButtonClicked(_ sender: Any) {
        if txtPaymentField.text == "" {
            
            let msg = UIAlertController(title: "Enter Payment Amount", message: "Must enter a payment amount", preferredStyle: UIAlertController.Style.alert)
            msg.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                msg .dismiss(animated: true, completion: nil)
            }))
            
            present(msg, animated: true, completion: nil)
            
        }else{
            
            let msg = UIAlertController(title: "Confirm Payment", message: "Are you sure you want to make the Payment of $" + txtPaymentField.text!, preferredStyle: UIAlertController.Style.alert)
            msg.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                msg.dismiss(animated: true, completion: nil)
                self.makePayment()
            }))
            msg.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                msg .dismiss(animated: true, completion: nil)
            }))
          
            
            present(msg, animated: true, completion: nil)
            
        }
    }
    

}


extension VCPayment: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        
        let currentText = textField.text ?? ""
        
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
    }
    
    //exit the textbox when the user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension String{
    
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            return digits.count <= maxDecimalPlaces
        }
        
        return false
    }
}

extension VCPayment: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PCell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "VIN: \(deal?.VIN ?? "nil")"
        case 1:
            cell.textLabel?.text = "YrMkMd: \(deal?.YrMakeMod ?? "nil")"
        case 2:
            cell.textLabel?.text = "Current Payoff: $\(deal?.curpay ?? "nil")"
        case 3:
            cell.textLabel?.text = "Curtailment Due: $\(deal?.curtailduenet ?? "nil")"
        default:
            cell.textLabel?.text = "Unused indexpath.row value: \(String(indexPath.row))"
        }
        
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = paymentMethod
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    



}
