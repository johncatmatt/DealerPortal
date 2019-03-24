//
//  VCNewVehList.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCNewVehList: UIViewController {

    @IBOutlet weak var lblColorLabel: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var dealerNo: String = ""
    var company: String = ""
    var paymentMethod: String = ""
    var currentIndex: Int = 999

    var deal: SearchMasterData? = nil

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
        // To Set your navigationBar title.
     //   self.title = "\(dealerNo)  \(company)"
       
        let upperTitle = NSMutableAttributedString(string: "\(dealerNo) \(company)", attributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!])
  //      let lowerTitle = NSMutableAttributedString(string: "\n\((dealerNo)) \(company)", attributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 11)! , NSAttributedString.Key.foregroundColor: UIColor.black])
        
      //  upperTitle.append(lowerTitle)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height:66))
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.attributedText = upperTitle  //assign it to attributedText instead of text
        self.navigationItem.titleView = label1
        
      /*
        // To Set your navigationBar backgound.
        self.barTintColor = .red
        
        // To Set your navigationBar title font and color.
        self.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.green, NSFontAttributeName:UIFont(name:"HelveticaNeue", size: 26)!]
        */
        
    }
    
    
    func GetVehiclesFromSite() {
    
        //starts the spinning icon
        showSpinner(onView: self.view)
        
        var tempArray: [VehicleData] = []
       print(dealerNo)
        
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
        print(buttonIndex)
        performSegue(withIdentifier: "ViewTitle", sender: self)
    }
    
 
    @IBAction func MakePayment(_ sender: Any) {
        buttonIndex = (sender as AnyObject).tag
        print("This buttonIndex for Make payment is: " + String(buttonIndex))
        print(currentArray[buttonIndex].VIN)
        print(currentArray[buttonIndex].YrMakeMod)
        print(currentArray[buttonIndex].curpay)
        print(currentArray[buttonIndex].curtailduenet)

        
        
        
        if currentArray[buttonIndex].VIN != "No Data Recieved"{
            
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
        
        
        //performSegue(withIdentifier: "MakePayment", sender: self)
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
        cell.btnPay.tag = indexPath.row
        
        
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = lblColorLabel.backgroundColor           //UIColor.init(red: 11, green: 20, blue: 26, alpha: 0.16) //colorForIndex(index: indexPath.row)
        } else {
            cell.backgroundColor = UIColor.white
        }
        //print(cell.btnTitle.tag)
        //print(cell.btnPayment.tag)
  
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    //prepares for the segue to the moredetail page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "MakePayment"{
            //sets the more page with the deals data
            let vc = segue.destination as! VCPayment
           
            vc.deal = currentArray[buttonIndex]
            
            vc.paymentMethod = paymentMethod
        }else if segue.identifier == "ViewTitle"{
            let vcT = segue.destination as! VCTitle
            //print(buttonIndex)
            vcT.vin = currentArray[buttonIndex].VIN
            vcT.vehicle = currentArray[buttonIndex]
            
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
