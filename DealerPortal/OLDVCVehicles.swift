//
//  ViewController.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 12/26/18.
//  Copyright © 2018 Matthew Sansoucie. All rights reserved.
//

import UIKit

class OLDVCVehicles: UIViewController {
    //outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var DealerTitle: UINavigationItem!
    
    //dealer
    var dealer = ""
    
    
    //data array for all the dealers data
    var TableDealsArray: [DealerData] = []
    var currentArray: [DealerData] = []
    
    var currentIndex = 999
    var paymentMethod = 999

    
    //on load event
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //calls the create array function
       // TableDeals = createArray()
        //connect to the tableview in the storyboard
        currentArray = TableDealsArray
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        DealerTitle.title = dealer
        
    }
}


/*-----------All of the functionality for the tableview-----------*/
extension OLDVCVehicles: UITableViewDelegate, UITableViewDataSource {
    
    //get the number of row in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
    }
    
    //handles each row of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let a = currentArray[indexPath.row]
        
        //declare the cell as the DealCell type, where we set its labels with its array values
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! DealCell
        cell.setDeal(d: a)
        
        return cell
    }
    
    
    //clicking a row in the table will bring them to the vehicles page where they can make a payment
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         //gets the index of the selected row and performs the segue
         currentIndex = indexPath.row
        
        let msgPM = UIAlertController(title: "Payment", message: "Choose Payment Option", preferredStyle: UIAlertController.Style.alert)
        msgPM.addAction(UIAlertAction(title: "Curtail Pmt", style: .default, handler: { (action: UIAlertAction!) in
            self.paymentMethod = 0
            msgPM.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "more", sender: self)
        }))
        msgPM.addAction(UIAlertAction(title: "Payoff", style: .default, handler: { (action: UIAlertAction!) in
            self.paymentMethod = 1
            msgPM.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "more", sender: self)
        }))
        msgPM.addAction(UIAlertAction(title: "Other Pmt", style: .default, handler: { (action: UIAlertAction!) in
            self.paymentMethod = 2
            msgPM.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "more", sender: self)
        }))
        msgPM.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            msgPM.dismiss(animated: true, completion: nil)
        }))
        present(msgPM, animated: true, completion: nil)
    }
    
    
     //prepares for the segue to the moredetail page
     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "more"{
            //sets the more page with the deals data
            let vc = segue.destination as! OLDVCMoreDetail
            let a = currentArray[currentIndex]
            //Moves the payment method over to the more page
            vc.curtailPayoffOther = paymentMethod
            //Moves the Deals Data to the more page through this array, clear it just to make sure its the only one in the selectedDealData
           // vc.selectedDealData.removeAll()
            vc.selectedDealData.append(a)
        }
    }
}

//Searchbar functionality
extension OLDVCVehicles: UISearchBarDelegate{
    //handles the scope of the radio buttons under the search bar
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    //handles the searchbar looking
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentArray = TableDealsArray
            tableView.reloadData()
            return
        }
        currentArray = TableDealsArray.filter({ (DealerData) -> Bool in
            DealerData.VIN.lowercased().contains(searchText.lowercased())           ||
            DealerData.MkMdlYr.lowercased().contains(searchText.lowercased())       ||
            DealerData.Title.lowercased().contains(searchText.lowercased())         ||
            DealerData.CurtailDue.lowercased().contains(searchText.lowercased())    ||
            DealerData.Payoff.lowercased().contains(searchText.lowercased())        ||
            DealerData.days.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
    
    //handels keyboard functionality
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
