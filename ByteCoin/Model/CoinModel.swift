//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Angelo Hudej on 22.04.21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    let currency: String
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}
