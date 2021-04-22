//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateAmount(_ coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E652B94E-7426-4B5D-A222-519B7514B770"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String)
    {
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        self.performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
            
                let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateAmount(self, coinModel: coin)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rateModel = CoinModel(rate: decodedData.rate, currency: decodedData.asset_id_quote)
            return rateModel
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
