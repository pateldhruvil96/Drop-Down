//
//  ViewController.swift
//  Dropdown-menu
//
//  Created by Dhruvil Patel on 3/18/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var btnNumberOfRooms: UIButton!
    
    var isTableVisible = false
    var result = Result()
    var product = [String]()
    var countries = ["USA","France","UK","Germany","India"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblDropDown.delegate = self
        tblDropDown.dataSource = self
        tblDropDownHC.constant = 0
        parseJSON()
        
        let nibCustomTableViewCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tblDropDown.register(nibCustomTableViewCell, forCellReuseIdentifier: "CustomTableViewCell")
        
        btnNumberOfRooms.roundAllcorners(radius: 15)
        tblDropDown.roundBottomCorners(radius: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- UITableView delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.sales.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDropDown.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.label.text = result.sales[indexPath.row].prod
        product.append(result.sales[indexPath.row].prod)
        cell.topCountryButtonOutlet.tag = indexPath.row
        cell.topCountryButtonOutlet.addTarget(self, action: #selector(moveToNextScreen), for: .touchDown)
        return cell
    }
    func calDifferentCountriesTotalValue(data:[ResultItem],countryIndex:Int)->Int{
       let totalValue = data.filter({$0.country == countries[countryIndex]}).compactMap({$0.price}).reduce(0, +)
        return totalValue
    }
    @objc func moveToNextScreen(_ sender: UIButton){
        var maxSum = 0
        var sum = 0
        var selectedCountry = String()
        let productSelected = result.sales[sender.tag].prod
        let productSelectedData = result.sales.filter({$0.prod == productSelected})
        for i in countries{
            sum = calDifferentCountriesTotalValue(data:productSelectedData , countryIndex: countries.index(of: i)!)
            print("\(i):\(sum)")
            if(sum>maxSum){
                maxSum = sum
                selectedCountry = i
            }
        }
        self.showAlert(withTitle: "Country with max total sales of product \(productSelected):", andMessage: selectedCountry)
        print("Country with maximum total sales:\(selectedCountry)")
    }


    @IBAction func selectNumberOfRooms(_ sender : AnyObject) {
        btnNumberOfRooms.roundTopCorners(radius: 15)
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
             self.tblDropDownHC.constant = 500
            self.btnNumberOfRooms.roundTopCorners(radius: 15)
            } else {
                self.tblDropDownHC.constant = 0
                self.isTableVisible = false
                self.btnNumberOfRooms.roundAllcorners(radius: 15)
            self.view.layoutIfNeeded()
        }
        }
    }
    func parseJSON(){
        guard let path = Bundle.main.path(forResource: "input_ios", ofType: "json")else{return}
        
        let url = URL(fileURLWithPath: path)
        do{
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
               // print(result)
        }catch{
            print("Error:\(error)")
        }
    }
    func showAlert(withTitle title : String?, andMessage message : String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
        }))
        
        if presentedViewController == nil {
            self.present(alertController, animated: true, completion: nil)
        } else{
            self.dismiss(animated: false) { () -> Void in
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}
extension UIView {
    func roundTopCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    func roundBottomCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    func roundAllcorners(radius: CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
   
}
