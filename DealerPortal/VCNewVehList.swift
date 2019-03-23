//
//  VCNewVehList.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCNewVehList: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
  
    @IBOutlet weak var titleButton: UIButton!
    
    var dealerNo: String = ""
    var paymentMethod: String = ""
    var currentIndex: Int = 999
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var TableVehiclesArray: [VehicleData] = []
    var SearchArray: [VehicleData] = []
    var currentArray: [VehicleData] = []
    
    var buttonIndex = 9999
    
    struct DealerVehicleList: Decodable {
        let vl: [veh]
    }
    struct veh: Decodable {
        var YrMakeMod : String
        var Vin : String
        var curpayoff : String
        var curtailduenet : String
        var tit_Number : String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         GetVehiclesFromSite()

        
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
    }
    
    
    func GetVehiclesFromSite() {
    
        //starts the spinning icon
        showSpinner(onView: self.view)
        
        var tempArray: [VehicleData] = []
        
        let todoEndpoint: String = "https://secureservice.autouse.com/dlrweb/WebService1.asmx/getvehicle?dlrno=\(dealerNo)"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest){ data, response, error in
            
            guard error == nil else {
                print("Error calling GET: \(error!)")
                return
            }
            
            guard let data = data else { print("DATA error"); return }
            //print(data)
            
            do {
                //decodes the vehicles from the json
                let myVehList = try JSONDecoder().decode(DealerVehicleList.self, from: data)
                
                DispatchQueue.main.async {
                    for v in myVehList.vl{
                        let myVeh = VehicleData(VIN: v.Vin, YrMakeMod: v.YrMakeMod, curpayoff: v.curpayoff, curtailduenet: v.curtailduenet, title: v.tit_Number)
                        tempArray.append(myVeh)
                    }
                
                   if myVehList.vl.isEmpty{
                    tempArray = [VehicleData(VIN: "", YrMakeMod: "", curpayoff: "", curtailduenet: "", title: "")]
                    }
                    self.TableVehiclesArray = tempArray
                    self.currentArray = tempArray
                    self.TableView.reloadData()
                    //stops the spinning icon
                    self.removeSpinner()
                }
            }catch let jsonErr{
                print("JSON Error: ", jsonErr)
            }
        }
        task.resume()
    }
    
    @IBAction func ToTitle(_ sender: Any) {
        buttonIndex = (sender as AnyObject).tag
        performSegue(withIdentifier: "ViewTitle", sender: self)
    }
    
 
    
}



extension VCNewVehList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let vh = currentArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell") as! VehicleCell
        cell.setVehicles(v: vh)
        cell.btnTitle.tag = indexPath.row
  
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //gets the index of the selected row and performs the segue
        currentIndex = indexPath.row
        
        if currentArray[currentIndex].VIN != "No Data Recieved"{
        
        let msgPM = UIAlertController(title: "Payment", message: "Choose Payment Option", preferredStyle: UIAlertController.Style.alert)
        msgPM.addAction(UIAlertAction(title: "Curtail Pament", style: .default, handler: { (action: UIAlertAction!) in
            self.paymentMethod = "Curtail Payment"
            msgPM.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "MakePayment", sender: self)
        }))
        msgPM.addAction(UIAlertAction(title: "Payoff", style: .default, handler: { (action: UIAlertAction!) in
            self.paymentMethod = "Payoff"
            msgPM.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "MakePayment", sender: self)
        }))
        msgPM.addAction(UIAlertAction(title: "Other Payment", style: .default, handler: { (action: UIAlertAction!) in
            self.paymentMethod = "Other Payment"
            msgPM.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "MakePayment", sender: self)
        }))
        msgPM.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            msgPM.dismiss(animated: true, completion: nil)
        }))
        present(msgPM, animated: true, completion: nil)
        }
    }
    
    
   /* func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(currentArray[currentIndex].title)
    }*/
    
    //prepares for the segue to the moredetail page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "MakePayment"{
            //sets the more page with the deals data
            let vc = segue.destination as! VCPayment
            let a = currentArray[currentIndex]
            vc.deal = a
            vc.paymentMethod = paymentMethod
        }else if segue.identifier == "ViewTitle"{
            let vcT = segue.destination as! VCTitle
            //print(buttonIndex)
            vcT.vin = currentArray[buttonIndex].VIN
            
        }
    }

}
//-------------------------------------------------------------------------------------------------------
extension VCNewVehList: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          guard !searchText.isEmpty else {
            currentArray = TableVehiclesArray
            TableView.reloadData()
            return
        }
        currentArray = TableVehiclesArray.filter({ (VehicleData) -> Bool in
            VehicleData.VIN.lowercased().contains(searchText.lowercased()) ||
            VehicleData.curpay.lowercased().contains(searchText.lowercased()) ||
            VehicleData.curtailduenet.lowercased().contains(searchText.lowercased()) ||
            VehicleData.YrMakeMod.lowercased().contains(searchText.lowercased())  })
        
        TableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
}

var vSpinner : UIView?

var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

extension UIViewController {
    
    func showSpinner(onView : UIView){
       // print("SHOWING SPINNER")
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
        
        vSpinner?.bringSubviewToFront(onView)
        vSpinner?.isHidden = false
    }
    
    func removeSpinner(){
       // print("STOPPING SPINNER")
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
            vSpinner?.isHidden = true
        }
    }
    
    
}
