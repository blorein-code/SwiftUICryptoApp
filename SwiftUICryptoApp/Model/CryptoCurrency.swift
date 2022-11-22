//
//  CryptoCurrency.swift
//  SwiftUICryptoApp
//
//  Created by Berke Topcu on 22.11.2022.
//

import Foundation

struct CryptoCurrency : Hashable,Decodable,Identifiable {
    
    let id = UUID()
    let currency : String
    let price : String
    
    
    //Sağ taraf gelen modeldeki isim, Sol taraf bizdeki model karşılığı
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
}
