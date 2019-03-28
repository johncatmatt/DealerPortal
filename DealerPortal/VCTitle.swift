//
//  VCTitle.swift
//  DealerPortal
//
//  Created by Matthew Sansoucie on 3/23/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import WebKit

class VCTitle: UIViewController {

    
    var vehicle: VehicleListData? = nil
    var vin: String = ""

   
    
    @IBOutlet weak var lblNoTitleMsg: UILabel!
    @IBOutlet weak var myWebView: WKWebView!
    
    struct TitleByteArray: Decodable {
        let vl: [t]
    }
    struct t: Decodable {
        var imgData: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getTitle()

    }
    
    
    
    func getTitle(){
        //starts the spinning icon
       /*/ print(vehicle?.VIN)
        print(vehicle?.YrMakeMod)
        print(vehicle?.title)*/
        showSpinner(onView: self.view)
        
        //var tempArray: [] = []
        let todoEndpoint: String = "https://secureservice.autouse.com/dlrweb/WebService1.asmx/getTitle?vin=\(vin)"
        print(todoEndpoint)
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
            print(data)
            
            do {
                //decodes the vehicles from the json
                let t = try JSONDecoder().decode(TitleByteArray.self, from: data)
                
                DispatchQueue.main.async {
                    
                    if t.vl.isEmpty{
                        self.lblNoTitleMsg.isHidden = false
                      
                    }else{
                        self.lblNoTitleMsg.isHidden = true
                        for vTitle in t.vl{
                            if  let decodeData = Data(base64Encoded: vTitle.imgData, options: .ignoreUnknownCharacters) {
                                self.myWebView.load(decodeData, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(fileURLWithPath: ""))
                            }
                        }
                    }
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
