//
//  ViewController.swift
//  cartDetail
//
//  Created by shahid mohd on 15/09/18.
//  Copyright © 2018 shahidmohd. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var cartTotal: UILabel!
    
    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var products:[NSDictionary] = []
    var cartDetails:NSDictionary = [:]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartDetailCell", for: indexPath) as! CartDetailTableViewCell
        
        cell.cellView.layer.shadowColor = UIColor.gray.cgColor
        cell.cellView.layer.shadowOpacity = 0.3
        cell.cellView.layer.shadowOffset = CGSize.zero
        cell.cellView.layer.shadowRadius = 6
        
        let url = URL(string: product["pimage"] as! String)
        cell.prodImage.kf.setImage(with: url)
        cell.productName.text = product["pname"] as! String
        cell.sp.text = product["price"] as! String
        cell.sizeOrweight.text = product["weight"] as! String
        cell.quantity.text = product["qnty"] as! String
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isKeyPresentInUserDefaults(key: "cartDetail"){
            
       
        cartDetails = (UserDefaults.standard.object(forKey: "cartDetail") as? NSDictionary)!
            self.discount.text = (self.cartDetails["discount_amt"] as? String)!
            //                       self.cartTotal.text = (cartDetail!["products"] as? String)!
            
            self.subTotal.text = (self.cartDetails["cart_subtotal"] as? String)!
        products = (cartDetails["products"] as? [NSDictionary])!
            
        tableView.reloadData()
             }
        print("MID===>\(UIDevice.current.identifierForVendor!.uuidString)")
        getCartDetail()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func getCartDetail() {
        let defaults = UserDefaults.standard
        let client_id = defaults.string(forKey: "userId")
        let upload_parameter:[String: Any] = ["uid":"10706","mid": "56DEE39D-CB14-4630-A765-A990AFFE3633","device_type":"iOS"]
        print(upload_parameter)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in upload_parameter {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, to:"http://ethrobasket.com/mb_beta/Itemcartapi/usercart/")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                   
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        self.cartDetails = (JSON as? [String: Any] as NSDictionary?)!
                        UserDefaults.standard.removeObject(forKey: "cartDetail")

                        UserDefaults.standard.set(self.cartDetails, forKey:"cartDetail")

                        print(self.cartDetails)
                        
                        self.products = (self.cartDetails["products"] as? [NSDictionary])!
                        print("this is list of productsss")
                        print(self.products)
                        
                        self.discount.text = (self.cartDetails["discount_amt"] as? String)!
//                       self.cartTotal.text = (cartDetail!["products"] as? String)!
                        
                        self.subTotal.text = (self.cartDetails["cart_subtotal"] as? String)!
                        
                        
                        self.tableView.reloadData()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            self.navigationController?.popViewController(animated: true)
//                        }
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

