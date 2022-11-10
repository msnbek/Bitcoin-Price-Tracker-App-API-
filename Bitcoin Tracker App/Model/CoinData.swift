//
//  File.swift
//  Bitcoin Tracker App
//
//  Created by Mahmut Şenbek on 10.11.2022.
//

import Foundation


struct CoinData: Decodable {
    
    var rate: Double
    var asset_id_quote: String
}
