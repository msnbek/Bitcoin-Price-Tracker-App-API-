//
//  Model.swift
//  Bitcoin Tracker App
//
//  Created by Mahmut Şenbek on 10.11.2022.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdateBTCPrice(btcPrice: String, currencyName: String)
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    var delegate : CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "1179F97F-ADE7-4C09-AD83-88AD72A68CAF"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func fetchPrice(currenyName: String) {
        
        
    }

    func getCoinPrice(for currency : String) {
        
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let newData = data {
                   
                    if let coinPrice = self.parseJson(newData) {
                        let price = String(format: "%.2f", coinPrice)
                        self.delegate?.didUpdateBTCPrice(btcPrice: price, currencyName: currency)
                    }
                 
                }

            }
            task.resume()
          
        }
    }
    
    func parseJson(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            //let name = decodedData.asset_id_quote
            print(rate)
           // print(name)
            return rate
    
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
