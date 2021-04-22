//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var LblAmount: UILabel!
    @IBOutlet weak var LblCurrency: UILabel!
    @IBOutlet weak var PikCurrency: UIPickerView!
    
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        PikCurrency.dataSource = self
        PikCurrency.delegate = self
    }
}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateAmount(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.LblAmount.text = coinModel.rateString
            self.LblCurrency.text = coinModel.currency
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}

