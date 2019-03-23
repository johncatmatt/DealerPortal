//
//  VCHome.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 12/28/18.
//  Copyright © 2018 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCFloorPlan: UIViewController, NSURLConnectionDelegate, XMLParserDelegate {

    @IBOutlet weak var lblLineAmmount: UILabel!
    @IBOutlet weak var lblOutstanding: UILabel!
    @IBOutlet weak var lblInTransit: UILabel!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var lblCurtailments: UILabel!
    @IBOutlet weak var DealerSearchBar: UISearchBar!
    @IBOutlet weak var txtVINBox: UITextField!
    
    @IBOutlet weak var btnToVehicleList: UIButton!
    @IBOutlet weak var SearchDealer: UISearchBar!
    
    var lineAmount =  "!!!TEMPDATA!!!"
    var outstanding = "$270,586.41"
    var inTransit = "$0.00"      //NOT SETUP
    var available = "$29,413.59"
    var curtailments = "$3,102.48"
    
    var dealer : String = "!!!!!!!!!!!TESTDATA!!!!!!!!!!!!!"
    var dealerNUM = "00373"
    
    struct jsonData: Decodable {
        var dealerNum : String
        var company : String
        var lineAmount : String
    }
    
    func SecureDealer1(){
      
        //setup URL
        let todoEndpoint: String = "https://secureservice.autouse.com/dlrweb/WebService1.asmx/HelloWorld?dlrno=\(dealerNUM)"
        
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        //start the url session
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest){ data, response, error in
            
            //check for errors
            guard error == nil else {
                print("Error calling GET: \(error!)")
                return
            }
            
            guard let data = data else { print("DATA error"); return }
            
            do {
                //decodes the json from the data
                let d = try JSONDecoder().decode(jsonData.self, from: data)
        
                DispatchQueue.main.async {
                    self.dealer =  d.company
                    //self.lineAmount = d.lineAmount
                   // self.lblLineAmmount.text = self.lblLineAmmount.text! + d.lineAmount
                    
                    //let msgAlert = UIAlertController(title: "Data Recieved!", message: "The following data was recieved by the app: \(d)", preferredStyle: UIAlertController.Style.alert)
                  //  msgAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                      //  msgAlert.dismiss(animated: true, completion: nil)
                    //}))
                   // self.present(msgAlert, animated: true, completion: nil)
                   
                }
                
                
            } catch let jsonErr{
                    print("JSON Error: ", jsonErr)
            }
        
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtVINBox.text = ""
        
        DealerSearchBar.delegate = self
        
        SecureDealer1()
        
        lblOutstanding.text = lblOutstanding.text! + outstanding
        lblInTransit.text = lblInTransit.text! + inTransit + " NOT YET SETUP"
        lblAvailable.text = lblAvailable.text! + available
        lblCurtailments.text = lblCurtailments.text! + curtailments
        lblLineAmmount.text = lblLineAmmount.text! + " $30,000.00"
        
        
    }

    
    //creates the dealerdata array
    func createArray() -> [DealerData] {
        
        var tempArray: [DealerData] = []
        
        struct moreData {
            var starts : String
            var board : String
            var miles : String
            var audit : String
            var titleNum : String
            var titleIn : String
            var titleOut : String
            var refloors : String
            var advanceAndSetip : String
            var interestDue : String
            var serviceFees : String
            var phyDamCoverage : String
            var closeOutFee : String
            var titleChange : String
            var curtailmentsRecvd : String
            var dailyInterest : String
        }
        
        let dealsOtherData1 : moreData = moreData.init(starts: "09/18/18", board: "09/18/18", miles: "78790", audit: "N", titleNum: "NY 29902Z", titleIn: "05/11/18", titleOut: "", refloors: "1", advanceAndSetip: "$8561.55", interestDue: "$192.16", serviceFees: "$48.00", phyDamCoverage: "$0.00", closeOutFee: "$110.00", titleChange: "$0.00", curtailmentsRecvd: "$0.00", dailyInterest: "$1.90")
        
        let dealsOtherData2 : moreData = moreData.init(starts: "04/24/19", board: "04/23/19", miles: "6978", audit: "Y", titleNum: "NH 12345A", titleIn: "11/11/19", titleOut: "", refloors: "0", advanceAndSetip: "$9234.43", interestDue: "$207.17", serviceFees: "$39.00", phyDamCoverage: "$0.00", closeOutFee: "$212.00", titleChange: "$0.00", curtailmentsRecvd: "$0.00", dailyInterest: "$2.10")
        
        let deal1 = DealerData(Dealer: dealer, VIN: "JM1GJ1W69E1124882", MkMdlYr: "MAZD 6 2014", CurtailDue: "$516.89", title: "Recieved", payoff: "$11,178.10", days: "126", starts: dealsOtherData1.starts, board: dealsOtherData1.board, miles: dealsOtherData1.miles, audit: dealsOtherData1.audit, titleNum: dealsOtherData1.titleNum, titleIn: dealsOtherData1.titleIn, titleOut: dealsOtherData1.titleOut, refloors: dealsOtherData1.refloors, advanceAndSetip: dealsOtherData1.advanceAndSetip, interestDue: dealsOtherData1.interestDue, serviceFees: dealsOtherData1.serviceFees, phyDamCoverage: dealsOtherData1.phyDamCoverage, closeOutFee: dealsOtherData1.closeOutFee, titleChange: dealsOtherData1.titleChange, curtailmentsRecvd: dealsOtherData1.curtailmentsRecvd, dailyInterest: dealsOtherData1.dailyInterest)
        
        let deal2 = DealerData(Dealer: dealer, VIN: "1FAHP2E94FG136088", MkMdlYr: "FORD TAURUS 2015", CurtailDue: "$428.08", title: "Recieved", payoff: "$8,909.81", days: "100", starts: dealsOtherData2.starts, board: dealsOtherData2.board, miles: dealsOtherData2.miles, audit: dealsOtherData2.audit, titleNum: dealsOtherData2.titleNum, titleIn: dealsOtherData2.titleIn, titleOut: dealsOtherData2.titleOut, refloors: dealsOtherData2.refloors, advanceAndSetip: dealsOtherData2.advanceAndSetip, interestDue: dealsOtherData2.interestDue, serviceFees: dealsOtherData2.serviceFees, phyDamCoverage: dealsOtherData2.phyDamCoverage, closeOutFee: dealsOtherData2.closeOutFee, titleChange: dealsOtherData2.titleChange, curtailmentsRecvd: dealsOtherData2.curtailmentsRecvd, dailyInterest: dealsOtherData2.dailyInterest)
        
        tempArray.append(deal1)
        tempArray.append(deal2)
        
        return tempArray
    }

    
    
   @IBAction func ToDeal(_ sender: Any) {
    performSegue(withIdentifier: "toVehicles", sender: Any?.self)
    }
    
    
    
    @IBAction func ToNewVehLIST(_ sender: Any) {
        
        let t = SearchDealer.text
        if(t == ""){
            let msg = UIAlertController(title: "Enter Dealer #", message: "Must enter a valid Dealer Number", preferredStyle: UIAlertController.Style.alert)
            msg.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                msg .dismiss(animated: true, completion: nil)
            }))
            
            present(msg, animated: true, completion: nil)
            
        }else{
             performSegue(withIdentifier: "ToVehicleGrid", sender: Any?.self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVehicles"{
            let vc = segue.destination as! VCVehicles
            //Dealer will be set here
            vc.dealer = dealer
            vc.TableDealsArray = createArray()
        }else if segue.identifier == "ToVehicleGrid"{
            let vcv = segue.destination as! VCNewVehList
            vcv.dealerNo = SearchDealer.text!
          /*  vcv.startLoadingIcon()
            vcv.GetVehiclesFromSite()
            vcv.stopLoadingIcon()*/
            //vcv.showSpinner(onView: vcv.view)
            
            
        }
    }
}

extension VCFloorPlan: UISearchBarDelegate{
    
    //handles the scope of the radio buttons under the search bar
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    //handles the searchable text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
