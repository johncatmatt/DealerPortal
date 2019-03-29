//
//  VCSearchMaster.swift
//  DealerPortal
//
//  Created by John Sansoucie on 3/24/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCSearchMaster: UIViewController {

  //  @IBOutlet weak var lbloutstand: UITableView!
    
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    
    //  @IBOutlet weak var lbllineAmount: UITableView!
  //  @IBOutlet weak var lblunits: UITableView!
  //  @IBOutlet weak var lblcifNo: UILabel!
    
  
    var currentIndex: Int = 999
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var TableVehiclesArray: [SearchMasterData] = []
    var SearchArray: [SearchMasterData] = []
    var currentArray: [SearchMasterData] = []
    //  var dealerNo: String = "00373"
    var buttonIndex = 9999
    
    struct SearchMasterList: Decodable {
        let vl: [veh]
    }
    struct veh: Decodable {
        var dealerNo : String
        var cifNo : String
        var company : String
        var lineAmount : String
        var outstand : String
        var units : String
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

           GetVehiclesFromSite()
        
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        
        // To Set your navigationBar title.
     //   self.title = "Dealer: \(dealerNo)"
         self.title = "AUTO USE / FloorPlan Dealers"        // Do any additional setup after loading the view.
        lblColor.isHidden = true
        
    }
    
    func GetVehiclesFromSite() {
        
        //starts the spinning icon
        showSpinner(onView: self.view)
        
        var tempArray: [SearchMasterData] = []
        //  print(dealerNo)
        //"https://secureservice.autouse.com/dlrweb/WebService1.asmx/getvehicle?dlrno=\(dealerNo)"
        let todoEndpoint: String = "https://secureservice.autouse.com/dlrweb/WebService1.asmx/getSearchList?dlrNo=0"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            self.removeSpinner()
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest){ data, response, error in
            
            guard error == nil else {
                print("Error calling GET: \(error!)")
                self.removeSpinner()
                return
            }

            guard let data = data else { print("DATA error"); return }
            //print(data)
            
            do {
                //decodes the vehicles from the json
                let myVehList = try JSONDecoder().decode(SearchMasterList.self, from: data)
                
                DispatchQueue.main.async {
                    for v in myVehList.vl{
                        let myVeh = SearchMasterData(dealerNo: v.dealerNo, cifNo: v.cifNo, company: v.company, lineAmount: v.lineAmount, outstand: v.outstand, units: v.units)
              //   print(myVeh.company)
                        tempArray.append(myVeh)
                    }
                    
                    if myVehList.vl.isEmpty{
                        tempArray = [SearchMasterData(dealerNo: "", cifNo: "", company: "", lineAmount: "", outstand: "", units: "")]
                    }
                    self.TableVehiclesArray = tempArray
                    self.currentArray = tempArray
                    self.TableView.reloadData()
                    //stops the spinning icon
                    self.removeSpinner()
                }
            }catch let jsonErr{
                print("JSON Error: ", jsonErr)
                self.removeSpinner()
            }
        }
        task.resume()
    }
    
  
    
   
    

}

extension VCSearchMaster: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vh = currentArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchMasterCell") as! SearchMasterCell
        cell.setSearchMaster(v: vh)
        cell.btndealerNo.tag = indexPath.row
        
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = lblColor.backgroundColor           //UIColor.init(red: 11, green: 20, blue: 26, alpha: 0.16) //colorForIndex(index: indexPath.row)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
        
    }

    
    
    @IBAction func ToNewVehList(_ sender: Any) {
        buttonIndex = (sender as AnyObject).tag
        print(buttonIndex)
        performSegue(withIdentifier: "NewVehList", sender: self)
    }
    
    
    
  /*
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
 */
    
    /* func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     print(currentArray[currentIndex].title)
     }*/
    
  
  
    //prepares for the segue to the moredetail page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
     //   if segue.identifier == "MakePayment"{
            //sets the more page with the deals data
            let vc = segue.destination as! VCVehicleList
            let a = currentArray[buttonIndex]
            vc.deal = a
            vc.dealerNo = a.dealerNo
            vc.company = a.company
        print(a.dealerNo)
           print(a.company)
        
        //  }else if segue.identifier == "ViewTitle"{
      //      let vcT = segue.destination as! VCTitle
      //      //print(buttonIndex)
      //      vcT.vin = currentArray[buttonIndex].VIN
            
      //  }
    }
   
    
    
    
    
    
}
//-------------------------------------------------------------------------------------------------------
extension VCSearchMaster: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentArray = TableVehiclesArray
            TableView.reloadData()
            return
        }
        currentArray = TableVehiclesArray.filter({ (searchMasterData) -> Bool in
            searchMasterData.company.lowercased().contains(searchText.lowercased()) ||
                searchMasterData.dealerNo.lowercased().contains(searchText.lowercased()) ||
                searchMasterData.lineAmount.lowercased().contains(searchText.lowercased()) ||
                searchMasterData.cifNo.lowercased().contains(searchText.lowercased()) ||
                searchMasterData.outstand.lowercased().contains(searchText.lowercased()) ||
                searchMasterData.units.lowercased().contains(searchText.lowercased())
                // ||
                //VehicleData.curtailduenet.lowercased().contains(searchText.lowercased()) ||
                // VehicleData.YrMakeMod.lowercased().contains(searchText.lowercased())
            
        })
        
        TableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
}

/*
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
*/
