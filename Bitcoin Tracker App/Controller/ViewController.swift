//
//  ViewController.swift
//  Bitcoin Tracker App
//
//  Created by Mahmut Şenbek on 10.11.2022.
//

import UIKit

class ViewController: UIViewController {
 
    
  var coinManager =  CoinManager()

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }
}

//MARK: - PickerViewDelegate

extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
       // bitcoinLabel.text = CoinManager
      
    }
    
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdateBTCPrice(btcPrice: String, currencyName: String) {
        DispatchQueue.main.sync {
            self.bitcoinLabel.text = String(btcPrice)
            self.currencyLabel.text = currencyName
        }
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
}

